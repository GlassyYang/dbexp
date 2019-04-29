#ifndef BTREE_HPP
#define BTREE_HPP

#include <cstring>
#include <stack>

#define BLOCKSIZE 1024
#define MIDBLK 512
#define MID(a, b) (((a) + (b)) >> 1)
#define CAN_INSERT(capacity) ((capacity) < BLOCKSIZE)
#define CAN_DELETE(capacity) ((capacity) >= MIDBLK)
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
	comparitor<value_type> comp;
	int binary_search(struct bnode*, value_type);
	void init_node(bnode*);
	void insert(bnode*, int, value_type);
	value_type remove(bnode*, int);
  public:
	btree(comparitor<value_type> comp);
	~btree();
	bool insert(value_type);
	bool find(value_type);
	bool remove(value_type);
};

template <class T>
btree<T>::btree(comparitor<T> comp)
{
	root = new bnode;
	init_node(root);
	this.comp = comp;
}

template <class T>
btree<T>::~btree()
{
	delete root;
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
			indexes.push(index);
		}
		else
		{
			return false;
		}
	}
	//查找到了该节点的插入位置，开始进行插入操作
	cur = nodes.pop();
	int index = indexes.pop();
	//两个指针为NULL说明当前修改的是叶子节点，不是NULL说明当前修改的是内部节点；需要注意的是另个变量不会有不同的值；
	bnode *left = NULL, *right = NULL;
	//说明插入之后会超
	while (!CAN_INSERT(cur->index))
	{
		//不能插入的话，执行扩展操作。扩展操作的步骤是：自插入点起将该节点分成两个节点，左边一部分，右边一部分，
		//然后扩展其父节点，将要插入的节点添加到其父节点中
		bnode *buf = new bnode;
		init_node(buf);
		int temp = cur->index - MIDBLK;
		memcpy((void*)(buf->value), (const void*)(cur->value + MIDBLK), SIZE(temp, T));
		memcpy((void*)(buf->child), (const void*)(cur->child + MIDBLK), SIZE(temp + 1, struct bnode*));
		buf->index = cur->index - MIDBLK;
		cur->index = MIDBLK;
		memset(static_cast<void*>(cur->value + MIDBLK), 0, temp);
		memset(static_cast<void*>(cur->child + MIDBLK), 0, temp);
		bnode *mblk;
		if(index >= MIDBLK)
		{
			index -= MIDBLK;
			mblk = buf;
		}
		else
		{
			mblk = cur;
		}
		//在做好这一切之后，需要将当前的值插入到父节点的位置上，然后将中间的值作为新的值插入
		temp = indexes.pop();
		T new_ins = cur->value[MIDBLK - 1];
		insert(mblk, temp, ins);
		ins = new_ins;
		if(left != NULL)
		{
			cur->child[temp] = left;
			buf->child[temp + 1] = right;
		}
		left = cur;
		right = buf;
		//为cur和index装载新的值，为空说明需要添加一层
		if(nodes.empty)
		{
			cur = new bnode;
			init_node(cur);
			index = 0;
			root = cur;
		}
		else
		{
			cur = nodes.pop();
			index = indexes.pop();
		}
	}
	//在能够插入之后直接将该值插入到其中去；
	insert(cur, index, ins);
	if (left != NULL)
	{
		cur->child[index] = left;
		cur->child[index + 1] = right;
	}
}

//找到返回true，没找到返回false
template <class T>
bool btree<T>::find(T e)
{
	struct bnode *cur = this.root;
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

template<typename T>
bool btree<T>::remove(T e)
{
	//在删除的过程中，如果没有找到则返回false
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
			indexes.push(index);
			nodes.push(cur);
		}
		else
		{
			index -= 1;		//当是正数的时候，返回的是原来的index + 1，所以需要-1.
			cur = cur->child[index];
			indexes.push(index);
			nodes.push(cur);
			break;
		}
	}
	if(cur == NULL)	//说明没有找到值
	{
		return false;
	}
	cur = nodes.pop();
	int index = indexes.pop();
	//如果找到的节点不是叶子节点，需要将删除的节点进行替换，选择前驱节点进行替换，因为前驱节点删除比较简单
	if(cur->child[index] != NULL)	//不是叶子节点，是内部节点
	{
		bnode *ntemp = cur;
		int itemp = index;
		index -= 1;
		cur = cur->child[index];
		indexes.push(index);
		nodes.push(cur);
		while(cur != NULL)
		{
			index = cur->index;
			cur = cur->child[index];
			indexes.push(index);
			nodes.push(cur);
		}
		//找到叶子节点之后，将之替换掉
		cur = nodes.top();
		index = indexes.top() - 1;
		swap(cur->value[index], ntemp->value[itemp]);
	}
	cur = nodes.pop();
	index = indexes.pop();
	//函数至此已经到达了叶子节点。因为删除只在叶子节点中进行，所以不用回溯
	while(cur != NULL && !CAN_DELETE(cur->index))
	{
		bnode *parent = nodes.top();
		int pindex = nodes.top();
		bnode *rb = (pindex + 1 < parent->index) ? parent[pindex + 1] : NULL;
		bnode *lb = (pindex - 1 >= 0) ? parent[pindex + 1] : NULL;
		//如果其右兄弟节点能够删除，则从其中删除最左边的节点移至父节点的当前位置上，将父节点上的值从其中
		//移到将要删除的位置上
		//调整cur，使指针移到末尾处
		remove(cur, index);
		index = cur->index;
		cur->index++;
		if(rb != NULL)
		{
			cur->value[index] = parent->value[pindex];
			if(CAN_DELETE(rb->index))
			{
				parent->value[pindex] = remove(rb, 0);
				cur = NULL;
			}
			else
			{
				//进行合并
				memcpy((void*)(cur->value + index), (void*)(rb->value), SIZE(rb->index, T));
				//合并之后需要递归检查父节点是否满足要求
				cur->index += rb->index;
				delete rb;
				cur = parent;
				index = pindex;
				parent = nodes.pop();
				pindex = indexes.pop();
			}
		}
		else if(lb != NULL)
		{
			pindex -= 1;
			lb->value[index] = parent->value[pindex];
			if(CAN_DELETE(lb->index))
			{
				parent->value[pindex] = remove(rb, rb->index - 1);
				cur = NULL;
			}else
			{
				memcpy((void*)(lb->value + lb->index), (void*)(cur->value), cur->index);
				lb->index += cur->index;
				delete cur;
				//检查父节点是否满足要求
				cur = parent;
				index = pindex;
				parent = nodes.pop();
			}
		}
		if(nodes.empty())
		{
			if(parent->index > 1)
			{
				remove(parent, pindex);
			}
			else
			{
				root = cur;
				delete parent;
			}
			break;
		}
	}
}
/**
 * 二分查找函数，找到返回索引+1，否则返回负值，其相反数是该节点应该插入的地方+1；
 * 当返回0时，代表没有找到，即值比当前节点中所有的直都小
 */
template <class T>
int btree<T>::binary_search(struct bnode *node, T e)
{
	int begin = 0, end = node->index;
	int middle = MID(begin, end);
	while (middle != begin)
	{
		int temp = comp.compate(node->value[middle], e);
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
			return middle;
		}
	}
	int temp = comp.compare(node->value[middle]);
	if (temp == 0)
	{
		return middle + 1;
	}
	else if (temp < 0)
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
	root->index = 0;
	memset(static_cast<void *>(root->child), 0, SIZE(BLOCKSIZE + 1, struct bnode *));
	memset(static_cast<void *>(root->value), 0, SIZE(BLOCKSIZE, T));
}

template <class T>
void btree<T>::insert(struct bnode *node, int index, T e)
{
	for (int i = node->index; i > index; i--)
	{
		node->value[i] = node->value[i - 1];
		node->child[i] = node->child[i - 1];
	}
	node->value[index] = e;
	node->index++;
}

//函数只能删除叶子节点上的值。
template<typename T>
T btree<T>::remove(bnode *node, int index)
{
	T temp = node->value[index];
	node->index;
	for(int i = index; i < node->index; i++)
	{
		node->value[i] = node->value[i + 1];
	}
	if(node->child[index] != NULL)
	{
		for(int i = index; i < node->index + 1; i++)
		{
			node->child[i] = node->child[i + 1];
		}
	}
	node->index--;
	return temp;
}
} // namespace dbexp
#endif