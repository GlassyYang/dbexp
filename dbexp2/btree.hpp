#ifndef BTREE_HPP
#define BTREE_HPP

#include <cstring>
#include <stack>

#define ME_DEBUG
//调试模式
#ifndef ME_DEBUG

#define BLOCKSIZE 1023
#define MIDBLK 511
#else
#define BLOCKSIZE 5
#define MIDBLK 2
#endif
#define MID(a, b) (((a) + (b)) >> 1)
#define CAN_INSERT(capacity) ((capacity) < BLOCKSIZE)
#define CAN_DELETE(capacity) ((capacity) > MIDBLK)
#define SIZE(a, T) ((a) * sizeof(T))
namespace dbexp
{

template <class value_type>
class comparitor
{
public:
	virtual int compare(value_type a, value_type b) = 0;
};

template <class value_type>
class btree
{
private:
	struct bnode
	{
		value_type value[BLOCKSIZE];
		struct bnode *child[BLOCKSIZE + 1];
		int index;
	} * root;
	comparitor<value_type> *comp;
	int binary_search(struct bnode *, value_type);
	void init_node(bnode *);
	void insert(bnode *, int, value_type);
	value_type remove(bnode *, int);
	void finalize(bnode *node);
	int adjust(bnode* parent, bnode *node, int index);

public:
	btree(comparitor<value_type> *comp);
	~btree();
	bool insert(value_type);
	bool find(value_type);
	bool remove(value_type);
};

template <class T>
btree<T>::btree(comparitor<T> *comp)
{
	root = new bnode;
	init_node(root);
	this->comp = comp;
}

template <class T>
btree<T>::~btree()
{
	//finalize(root);
}

template <class T>
void btree<T>::finalize(bnode *node)
{
	for (int i = 0; i <= node->index; i++)
	{
		if (node->child[i] != NULL)
		{
			finalize(node->child[i]);
			node->child[i] = NULL;
		}
	}
	delete node;
}

template <class T>
bool btree<T>::insert(T e)
{
	using namespace std;
	//copy要插入的值
	T ins = e;
	stack<bnode *> nodes;
	stack<int> indexes;
	bnode *cur = root;
	while (cur != NULL)
	{
		nodes.push(cur);
		int index = binary_search(cur, e);
		if (index <= 0)
		{
			cur = cur->child[-index];
			indexes.push(-index);
		}
		else
		{
			return false;
		}
	}
	//查找到了该节点的插入位置，开始进行插入操作
	cur = nodes.top();
	nodes.pop();
	int index = indexes.top();
	indexes.pop();
	//两个指针为NULL说明当前修改的是叶子节点，不是NULL说明当前修改的是内部节点；需要注意的是另个变量不会有不同的值；
	bnode *left = NULL, *right = NULL;
	//说明插入之后会超
	while (!CAN_INSERT(cur->index))
	{
		//不能插入的话，执行扩展操作。扩展操作的步骤是：自插入点起将该节点分成两个节点，左边一部分，右边一部分，
		//然后扩展其父节点，将要插入的节点添加到其父节点中
		bnode *buf = new bnode;
		init_node(buf);
		int cut = index > MIDBLK ? MIDBLK + 1 : MIDBLK;
		memcpy((void *)(buf->value), (const void *)(cur->value + cut), SIZE(BLOCKSIZE - cut, T));
		memcpy((void *)(buf->child), (const void *)(cur->child + cut), SIZE(BLOCKSIZE - cut + 1, struct bnode *));
		buf->index = cur->index - cut;
		cur->index = cut;
		memset(static_cast<void *>(cur->value + cut), 0, SIZE(BLOCKSIZE - cut, T));
		memset(static_cast<void *>(cur->child + cut), 0, SIZE(BLOCKSIZE - cut + 1, struct bnode *));
		if (index > MIDBLK)
		{
			index -= cut;
			insert(buf, index, ins);
			buf->child[index] = left;
			buf->child[index + 1] = right;
		}
		else
		{
			insert(cur, index, ins);
			cur->child[index] = left;
			cur->child[index + 1] = right;
		}
		//在做好这一切之后，需要将当前的值插入到父节点的位置上，然后将中间的值作为新的值插入
		//需注意的是，如果父节点是空的，则说明刚刚插入的节点就是父节点，需要创建新的父
		ins = cur->value[MIDBLK];
		cur->index -= 1;
		left = cur;
		right = buf;
		//为cur和index装载新的值，为空说明需要添加一层
		if (nodes.empty())
		{
			cur = new bnode;
			init_node(cur);
			index = 0;
			root = cur;
		}
		else
		{
			cur = nodes.top();
			nodes.pop();
			index = indexes.top();
			indexes.pop();
		}
	}
	//在能够插入之后直接将该值插入到其中去；
	insert(cur, index, ins);
	if (left != NULL)
	{
		cur->child[index] = left;
		cur->child[index + 1] = right;
	}
	return true;
}

//找到返回true，没找到返回false
template <class T>
bool btree<T>::find(T e)
{
	struct bnode *cur = this->root;
	while (cur != NULL)
	{
		//使用二分查找
		int index = binary_search(cur, e);
		if (index <= 0)
		{
			cur = cur->child[-index];
		}
		else
		{
			return true;
		}
	}
	return false;
}

//TODO 删除操作
template <typename T>
bool btree<T>::remove(T e)
{
	//在删除的过程中，如果没有找到则返回false
	using namespace std;
	bnode *cur = root;
	bnode *parent;
	int index;
	while (cur != NULL)
	{
		index = binary_search(cur, e);
		if (index <= 0)
		{
			index = -index;
			parent = cur;
			cur = cur->child[index];
			if(cur == NULL)
			{
				return false;
			}
			if (!CAN_DELETE(cur->index))
			{
				index = adjust(parent, cur, index);
			}
		}
		else
		{
			index -= 1;
			break;
		}
	}
	parent = cur;
	bnode *left, *right;
	//如果找到的节点不是叶子节点，需要将删除的节点进行替换，选择前驱节点进行替换，因为前驱节点删除比较简单
	while (cur->child[index] != NULL) //不是叶子节点，是内部节点
	{
		//这儿的left和right是一定不会NULL的。
		left = cur->child[index];
		right = cur->child[index + 1];
		if (CAN_DELETE(left->index))
		{
			while (left != NULL)
			{
				if(!CAN_DELETE(left->index))
				{
					adjust(parent, left, right->index - 1);
				}
				parent = left;
				left = left->child[index];
			}
			swap(cur->value[index], parent->value[parent->index - 1]);
			parent->index -= 1;
			return true;
		}
		else if (CAN_DELETE(right->index))
		{
			while (right != NULL)
			{
				if(!CAN_DELETE(right->index))
				{
					adjust(parent, right, right->index - 1);
				}
				parent = right;
				right = right->child[index];
			}
			swap(cur->value[index], parent->value[parent->index - 1]);
			parent->index -= 1;
			return true;
		}
		else
		{
			left->value[left->index++] = cur->value[index];
			memcpy((void*)(left->value + left->index), (void*)(right->value), SIZE(right->index, T));
			memcpy((void*)(left->child + left->index), (void*)(right->child), SIZE(right->index + 1, bnode*));
			remove(cur, index);
			cur->index -= 1;
			cur->child[cur->index] = left;
			index = left->index - 1;
			left->index = left->index + right->index;
			delete right;
			parent = cur;
			cur = left;
		}
	}
	//如果是页节点，直接删除。
	remove(parent, index);
	return true;
}
/**
 * 二分查找函数，找到返回索引+1，否则返回负值，其相反数是该节点应该插入的地方+1；
 * 当返回0时，代表没有找到，即值比当前节点中所有的直都小
 * 函数的意义为：当返回的之大于0的时候，是所寻找的元素所在的位置-1；当返回的值小于等于0的时候，
 * 是元素所在的子节点的位置。
 */
template <class T>
int btree<T>::binary_search(struct bnode *node, T e)
{
	int begin = 0, end = node->index;
	if (node->index == 0)
	{
		return 0;
	}
	int middle = MID(begin, end);
	while (middle != begin)
	{
		int temp = comp->compare(node->value[middle], e);
		if (temp < 0)
		{
			begin = middle;
			middle = MID(begin, end);
		}
		else if (temp > 0)
		{
			end = middle;
			middle = MID(begin, end);
		}
		else
		{
			return middle + 1;
		}
	}
	int temp = comp->compare(node->value[middle], e);
	if (temp == 0)
	{
		return middle + 1;
	}
	else if (temp > 0)
	{
		return 0;
	}
	else
	{
		return -middle - 1;
	}
}

template <class T>
void btree<T>::init_node(bnode *node)
{
	node->index = 0;
	memset(static_cast<void *>(node->child), 0, SIZE(BLOCKSIZE + 1, struct bnode *));
	memset(static_cast<void *>(node->value), 0, SIZE(BLOCKSIZE, T));
}

template <class T>
void btree<T>::insert(struct bnode *node, int index, T e)
{
	node->child[node->index + 1] = node->child[node->index];
	for (int i = node->index; i > index; i--)
	{
		node->value[i] = node->value[i - 1];
		node->child[i] = node->child[i - 1];
	}
	node->value[index] = e;
	node->index++;
}

//函数只能删除叶子节点上的值。
template <typename T>
T btree<T>::remove(bnode *node, int index)
{
	T temp = node->value[index];
	for (int i = index; i < node->index; i++)
	{
		node->value[i] = node->value[i + 1];
	}
	if (node->child[index] != NULL)
	{
		for (int i = index; i < node->index + 1; i++)
		{
			node->child[i] = node->child[i + 1];
		}
	}
	node->index--;
	return temp;
}

template <class T>
int btree<T>::adjust(bnode *parent, bnode *node, int index)
{
	bnode *left = index == 0 ? NULL : parent->child[index - 1];
	bnode *right = index == parent->index - 1 ? NULL : parent->child[index + 1];
	if (left != NULL && CAN_DELETE(left->index))
	{
		//调整当前节点和左节点的值
		insert(node, 0, parent->value[index - 1]);
		parent->value[index - 1] = left->value[--left->index];
		node->child[0] = left->child[left->index + 1];
		left->child[left->index + 1] = NULL;
	}
	else if (right != NULL && CAN_DELETE(right->index))
	{
		//调整当前节点和右节点的值
		node->value[node->index] = parent->value[index];
		node->child[++node->index] = right->child[0];
		parent->value[index] = right->value[0];
		remove(right, 0);
	}
	else if (left != NULL)
	{
		//合并当前节点，父节点和左节点
		index -= 1;
		left->value[left->index++] = parent->value[index];
		memcpy((void *)(left->value + left->index), (void *)(node->value), SIZE(node->index, T));
		memcpy((void *)(left->child + left->index), (void *)(node->child), SIZE(node->index + 1, bnode *));
		remove(parent, index);
		parent->child[index] = left;
		delete node;
	}
	else if (right != NULL)
	{
		//合并当前节点，父节点和右节点
		node->value[node->index++] = parent->value[index];
		memcpy((void *)(node->value + node->index), (void *)(right->value), SIZE(right->index, T));
		memcpy((void *)(node->child + node->index), (void *)(right->child), SIZE(right->index + 1, bnode *));
		remove(parent, index);
		parent->child[index] = node;
		delete right;
	}
	return index;
}
} // namespace dbexp
#endif