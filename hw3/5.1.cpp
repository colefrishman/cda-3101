#include <iostream>
#include <math.h>

using namespace std;

void shiftRight(int & value, int shift){
    for(int i =0; i<shift; ++i){
        value = value>>1;
    }
} 

int addFloats(int float1, int float2){
    int result;

    int sign1 = (float1 >> 31) & 1;
    int sign2 = (float2 >> 31) & 1;
    int exp1 = (float1 >> 23) & 255;
    int exp2 = (float2 >> 23) & 255;
    int sig1 = (float1) & 8388607;
    int sig2 = (float2) & 8388607;

    sig1 += 8388608;
    sig2 += 8388608;
    exp1-=127;
    exp2-=127;

    cout << "Sign 1: " << sign1 << endl;
    cout << "Sign 2: " << sign2 << endl;
    cout << "Exp 1: " << exp1 << endl;
    cout << "Exp 2: " << exp2 << endl;
    cout << "Sig 1: " << sig1 << endl;
    cout << "Sig 2: " << sig2 << endl;

    int resultExp;
    
    int x = sig2>>max(32, exp1-exp2);
    cout << "sig 2: " << x << endl;

    if(exp1>exp2){
        shiftRight(sig2,exp1-exp2);
        resultExp = exp1;
    }
    else{
        shiftRight(sig1,exp2-exp1);
        resultExp = exp2;
    }

    int resultSign;
    int resultSig  = sig1 + (pow(-1, sign1+sign2) * sig2);

    if(resultSig>=16777216){
        resultExp+=1;
        resultSig>>=1;
    }
    else if(resultSig<8388608){
        resultExp-=1;
        resultSig<<=1;
    }
    if (resultSig<0){
        resultSign = -1*sign1;
    }
    else{
        resultSign = sign1;
    }
    cout << "sign: " << resultSign << endl;
    cout << "exp: " << resultExp << endl;
    cout << "sig: " << resultSig << endl;

    result = resultSign;
    result = (result << 8) + (resultExp+127);
    result = (result << 23) + (resultSig-8388608);
    return result;
}

int StringToWord(string number){
    int value;
    for(int i=0; i<32; ++i){
        value = value*2 + (number[i] - '0');
    }
    return value;
}
string WordToString(int word){
    string value = "";
    int number = word;
    for(int i=0; i<32; ++i){
        value = ((char) ((number & 1) + '0')) + value;
        number >>= 1;
    }
    return value;
}

int main(){
    string arg1 = "01001101100011110000110100011000";
    string arg2 = "10110101101001011011000100011001";
    int a1 = StringToWord(arg1);
    int a2 = StringToWord(arg2);
    cout << WordToString(addFloats(a1,a2));
}
