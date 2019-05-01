#ifndef ADDITION_HPP_INCLUDED
#define ADDITION_HPP_INCLUDED

class Addition
{
public:
    static int twoValues(const int x, const int y);

    template<typename T>
    static T twoValuesT(const T x, const T y){
      return x+y;
    }

};

#endif // ADDITION_HPP_INCLUDED
