#ifndef COMPARITOR_HPP
#define COMPARITOR_HPP

#include "btree.hpp"

namespace dbexp
{
struct itemData{
    int index;
    char value[13];
};

class itemComparitor : public comparitor<itemData>{
    public:
        virtual int compare(itemData a, itemData b);

};

int itemComparitor::compare(itemData a, itemData b)
{
    return a.index - b.index;
}

}

#endif