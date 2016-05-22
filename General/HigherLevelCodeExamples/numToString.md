# Converting from an integer to a string:
````c++
std::string numToString(int amount){
        std::string number;

        bool isNeg = amount < 0;
        if(isNeg){
                amount = abs(amount);
                number.push_back('-');
        }

        if( amount == 0){
                number.push_back('0');
                return number;
        }


        size_t digits = ceil(log10(amount));
        size_t modifier = pow(10,digits-1);
        size_t cumilation = 0;

        for(size_t i = 0 ; i < digits ; i++, modifier /= 10 ){
                size_t divVal = amount/modifier;
                number.push_back((divVal - cumilation) | 0b00110000);
                cumilation = divVal * 10;
        }
        return number;
}
````

This is for ASCII values. I doubt it'll work for UTF.
Doesn't work for multiples of ten... :?
