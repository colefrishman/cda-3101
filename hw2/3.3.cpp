#include <iostream>
#include <math.h>

using namespace std;

int main(){
    int bumble[11];
    bumble[0] = 0;
    bumble[1] = 1;
    cout << bumble[0] << endl;
    cout << bumble[1] << endl;
    for(int i = 2; i<=10; ++i){
        bumble[i] = 2*bumble[i-1] + pow(bumble[i-2], 2);
        cout << bumble[i] << endl;
    }
    return 0;
}