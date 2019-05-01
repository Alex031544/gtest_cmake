#include <limits.h>
#include "gtest/gtest.h"
#include "Addition.h"

class AdditionTest
  : public ::testing::Test
{
protected:
  virtual void SetUp() {
  }

  virtual void
  TearDown() {
  // Code here will be called immediately after each test
  // (right before the destructor).
  }
};

TEST_F(AdditionTest,twoValues){
  const int x = 4;
  const int y = 5;
  Addition addition;
  EXPECT_EQ(9,addition.twoValues(x,y));
  EXPECT_EQ(5,addition.twoValues(2,3));
}

TEST_F(AdditionTest,twoValuesT){
  Addition addition;

  const int xi = 4, yi = 5;
  EXPECT_EQ(9,addition.twoValuesT(xi,yi));
  EXPECT_EQ(5,addition.twoValuesT(2,3));

  const double xd=7.7, yd=2.2;
  EXPECT_EQ(9.9,addition.twoValuesT(xd,yd));
}
