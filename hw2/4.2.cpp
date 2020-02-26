#include <iostream>
#include <math.h>

using namespace std;


int bumble[11];

void Bumble(int n, int last, int seclast, int max){
    if(n>max){return;}
    int value = 2*last + pow(seclast, 2);
    bumble[n] = value;
    cout << bumble[n] << endl;
    if(n==max){
        return;
    }
    else{
        Bumble(n+1, value, last, max);
    }
}

int main(){
    bumble[0] = 0;
    bumble[1] = 1;
    cout << bumble[0] << endl;
    cout << bumble[1] << endl;
    Bumble(2, 1, 0, 10);
    return 0;
}
