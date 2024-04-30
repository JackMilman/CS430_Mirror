#include <stdlib.h>
#include <stdio.h>

typedef enum {
    INT, FLOAT, DOUBLE
} tag_t;

typedef union {
    int i;
    float f;
    double d;
} value_t;

typedef struct {
    tag_t tag;
    value_t val;
} number_t;

number_t create_int(int num);
number_t create_float(float num);
number_t create_double(double num);

number_t create_int(int num)
{
    number_t number;
    number.tag = INT;
    number.val.i = num;
    return number;
}

number_t create_float(float num)
{
    number_t number;
    number.tag = FLOAT;
    number.val.f = num;
    return number;
}

number_t create_double(double num)
{
    number_t number;
    number.tag = DOUBLE;
    number.val.d = num;
    return number;
}

number_t negate(number_t number)
{
    number_t negated;
    negated.tag = number.tag;
    switch (number.tag)
    {
        case INT:
            negated.val.i = -1 * number.val.i;
            break;
        case FLOAT:
            negated.val.f = -1 * number.val.f;
            break;
        case DOUBLE:
            negated.val.d = -1 * number.val.d;
            break;
        default:
            break;
    }
    return negated;
}

number_t add(number_t n1, number_t n2)
{
    if (n1.tag != n2.tag)
    {
        fprintf(stderr, "Invalid type comparison, exiting now...\n");
        exit(EXIT_FAILURE);
    }
    number_t sum;
    sum.tag = n1.tag;
    switch (n1.tag)
    {
        case INT:
        sum.val.i = n1.val.i + n2.val.i;
        break;
        case FLOAT:
            sum.val.f = n1.val.f + n2.val.f;
            break;
        case DOUBLE:
            sum.val.d = n1.val.d + n2.val.d;
            break;
        default:
            break;
    }
    return sum;
}

int
main(int argc, char *argv[])
{
    int i = 5;
    number_t i_num = create_int(i);
    number_t i_negative = negate(i_num);
    printf("Normal: %d\n", i_num.val.i);
    printf("Negated: %d\n", i_negative.val.i);

    float f = 12.4;
    float f2 = 15.6;
    number_t f_num = create_float(f);
    number_t f_num_2 = create_float(f2);
    number_t f_negative = negate(f_num);
    number_t f_sum = add(f_num, f_num_2);
    printf("Normal: %f\n", f_num.val.f);
    printf("Negated: %f\n", f_negative.val.f);
    printf("Sum: %f\n", f_sum.val.f);
    return EXIT_SUCCESS;
}