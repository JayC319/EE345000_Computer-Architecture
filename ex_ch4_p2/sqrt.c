/*
Just like integer division, these functions round down to an integer.
Running this program should produce the following output:

sqrt(3735928559) == 61122
61122^2 == 3735898884
sqrt(244837814094590) == 15647294
15647294^2 == 244837809522436

This algorithm comes from Jack W. Crenshaw's 1998 article in Embedded:
http://www.embedded.com/electronics-blogs/programmer-s-toolbox/4219659/Integer-Square-Roots
*/

#include <stdio.h>
#include <stdint.h>

uint16_t sqrt32(uint32_t a);

int main(void) {
	uint32_t small = 65500;
	uint32_t sqrt_small = sqrt32(small);
	uint32_t check_small = sqrt_small * sqrt_small;

	printf("\n\nsqrt(%u) == %u\n", small, sqrt_small);
	printf("%u^2 == %u\n", sqrt_small, check_small);

	return 0;
}

uint16_t sqrt32(uint32_t a) {
        uint32_t rem = 0, root = 0;
        int i;
        for (i = 32 / 2; i > 0; i--) {
                root <<= 1;
                rem = (rem << 2) | (a >> (32 - 2));
                a <<= 2;
                //printf("\t a==%u; root==%u; rem==%u\n", a, root, rem);
                
                printf("root: %d  rem: %d\n",root, rem);
                if (root < rem) {
                        rem -= root | 1;
                        root += 2;
                }

                printf("i = %d -> %d\n", i, i-1);
        }
        return root >> 1;
}