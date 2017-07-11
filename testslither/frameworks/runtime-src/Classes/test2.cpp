//
//  test2.cpp
//  testslither
//
//  Created by Mybo on 17/4/6.
//
//

//#include "test1.hpp"
#include "sss.hpp"
#include "test2.hpp"
int test2::gette2(){
    return te2;
}
void test2::sette2(int a){
    te2 = a ;
    sss_aaa = 0;
    switch (a) {
        case 0:do_again:
            goto do_again;  //死循环 标签容易打乱程序顺序
            break;
            
        default:
            break;
    }
}
