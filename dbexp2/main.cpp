#include <iostream>
#include <fstream>
#include <string>
#include "btree.hpp"
#include "comparitor.hpp"

using namespace std;
using namespace dbexp;
void readData(btree<itemData> &tree)
{
    ifstream ifile;
    ifile.open("./data.txt", ios::in);
    string line;
    while(getline(ifile, line)){
        string index = line.substr(0, line.find_first_of(' '));
        string value = line.substr(line.find_first_of(' ') + 1);
        itemData data;
        data.index = atoi(index.c_str());
        strcpy(data.value, value.c_str());
        tree.insert(data);
    }
}

void varifyRead(btree<itemData> &tree)
{
    ifstream ifile;
    ifile.open("./data.txt");
    int count = 0;
    string line;
    while(getline(ifile, line)){
        string index = line.substr(0, line.find_first_of(' '));
        string value = line.substr(line.find_first_of(' ') + 1);
        itemData data;
        data.index = atoi(index.c_str());
        strcpy(data.value, value.c_str());
        if(!tree.find(data))
        {
            count++;
        }
    }
    cout << "totally not find item: " << count << endl;
}

int main()
{
    comparitor<itemData> *comp = new itemComparitor();
    btree<itemData> root(comp);
    readData(root);
    varifyRead(root);
    cout << "finished" << endl;
    return 0;
}