#include <iostream>
#include <math.h>

using namespace std;


int bumble[11];

void Bumble(int n, int max){
    if(n>max){return;}
    bumble[n] = 2*bumble[n-1] + pow(bumble[n-2], 2);
    cout << bumble[n] << endl;
    if(n==max){
        return;
    }
    else{
        Bumble(n+1, max);
    }
}

int main(){
    bumble[0] = 0;
    bumble[1] = 1;
    cout << bumble[0] << endl;
    cout << bumble[1] << endl;
    Bumble(2, 10);
    return 0;
}
