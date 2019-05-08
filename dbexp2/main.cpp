#include <iostream>
#include <fstream>
#include <string>
#include "btree.hpp"
#include "comparitor.hpp"

#ifdef ME_DEBUG
#define DEBUG_SIZE 40
#endif

using namespace std;
using namespace dbexp;
void readData(btree<itemData> &tree)
{
    ifstream ifile;
    ifile.open("./data.txt", ios::in);
    string line;
#ifdef ME_DEBUG
    int count = 0;
#endif
    while(getline(ifile, line)){
        string index = line.substr(0, line.find_first_of(' '));
        string value = line.substr(line.find_first_of(' ') + 1);
        itemData data;
        data.index = atoi(index.c_str());
        strcpy(data.value, value.c_str());
        tree.insert(data);
#ifdef ME_DEBUG
        count++;
        if(count > DEBUG_SIZE){
            break;
        }
#endif
    }
}

void varifyRead(btree<itemData> &tree)
{
    ifstream ifile;
    ifile.open("./data.txt");
    int count = 0;
    int lineNum = 0;
    string line;
    while(getline(ifile, line)){
        string index = line.substr(0, line.find_first_of(' '));
        string value = line.substr(line.find_first_of(' ') + 1);
        itemData data;
        data.index = atoi(index.c_str());
        strcpy(data.value, value.c_str());
        if(!tree.find(data))
        {
            cout << "item not find, index is " << index << endl;
            count++;
        }
        lineNum++;
#ifdef ME_DEBUG
        if(lineNum > DEBUG_SIZE){
            break;
        }
#endif
    }
    cout << "totally not find item: " << count << endl;
}

void testDelete(btree<itemData> &tree)
{
    ifstream ifile("./data.txt");
    string line;
    int deleted = 0;
    while(getline(ifile, line))
    {
        string index = line.substr(0, line.find_first_of(' '));
        string value = line.substr(line.find_first_of(' ') + 1);
        itemData data;
        data.index = atoi(index.c_str());
        strcpy(data.value, value.c_str());
        if(tree.remove(data))
        {
            if(tree.find(data))
            {
                cout << "unsucceed delete, index " << index << endl;
            }
        }
        deleted++;
    }
}
int main()
{
    comparitor<itemData> *comp = new itemComparitor();
    btree<itemData> root(comp);
    readData(root);
    varifyRead(root);
    testDelete(root);
    cout << "finished" << endl;
    return 0;
}