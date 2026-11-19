#!/bin/bash

number1=5
number2=10
sum=$((number1 + number2))
difference=$((number2 - number1))
product=$((number1 * number2))
division=$((number2 / number1))

echo "The sum is $sum"; echo "The quotient is $division"
echo -e "The difference is $difference \n but the product is $product"
