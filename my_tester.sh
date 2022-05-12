#!/bin/bash

# Simple tester for push_swap.
## T0 = own tests
## T1 = Eval Sheet
## T2 = testing
## T3 = bonus checker

# Colours
RED="\033[0;31m"
GREEN="\033[0;32m"
DONE="\033[1;32m"
BLUE="\033[0;36m"
YEL="\033[0;33m"
DEF="\033[0m"

# Program input
if [[ "$1" == "m" ]]; then
	tests="0"
elif [[ "$1" == "t" ]]; then
	tests="2"
elif [[ "$1" == "c" ]]; then
	tests="3"
else
	tests="1"
fi

# Check for push_swap executable
if [[ -f push_swap ]]; then
	push_swap="./push_swap"
else
	echo -e "${RED}ERROR${DEF}: No push_swap executable found."
	exit 1
fi

# Run push_swap
run()
{
	echo -e "* Testing ARG=\"${YEL}$ARG${DEF}\""
	# "$push_swap" $ARG
	"$push_swap" $ARG > tmp # more readable
}

# Run checker bonus
run_c()
{
	echo "* Testing with ARG=\"$ARG\""
	"$checker" $ARG
	echo ""
}

# Run push_swap against checker
vs_checker()
{
	./push_swap $ARG | ./checker_Mac $ARG > out_tmp
	# ./push_swap $ARG | ./checker_linux $ARG > out_tmp

	# Check message from checker
	exit_msg=$(cat out_tmp)
	if [[ "$exit_msg" == "OK" ]]; then
		echo -e "${GREEN}$exit_msg${DEF}"
	else
		echo -e "${RED}Error${DEF}"
	fi

	# Delete created tmp files
	if [[ -f out_tmp ]]; then
		rm -f out_tmp
	fi
}

# Run error cases
check_error()
{
	echo "* Testing ARG=\"$ARG\""
	unset var
	./push_swap $ARG
	if [ $? -eq 1 ];
	then
		echo -e "${GREEN}OK${DEF}"
	else
		echo -e "${RED}Error${DEF}"
	fi
	echo ""
}

# Generate n number of random numbers
generate_random()
{
	# https://www.calculatorsoup.com/calculators/statistics/random-number-generator.php
	max=2147483648
	min=-2147483648
	unset rand_nb
	until_last=$(($1-1));
	for n in `seq "$until_last"`
	do
		# rand_nb+=$(jot -w  %i -r 1 $min $max)
		rand_nb+=$(($RANDOM % $max + $min))
		rand_nb+=" "
	done
	rand_nb+=$(($RANDOM % $max + $min))
	# rand_nb+=$(jot -w  %i -r 1 $min $max)
	unset var
	var=$(echo "$rand_nb" | wc -w)
	echo "$var random values generated"
}

# Compute number of operations
nb_op()
{
	unset var
	var=$(./push_swap $ARG | wc -l)
	echo "$var operations"
	echo ""
}

# Run, checker and nb operations
ps()
{
	run $ARG
	vs_checker $ARG
	nb_op $ARG
	read -n 1 -s -r -p "Press any key to continue"
	echo "
	"
}


#====================================
# Testing
if [[ $tests == "2" ]]; then
	## Test - 100 random
	# ARG="1003 -216 -3695 -4332 -419 -87 -447 -3969 -2358 4448 2778 -2406 2801 -3668 -3417 4102 2366 4316 1561 -1567 238 4573 1870 4747 486 1354 -1737 379 628 1594 -3141 245 1940 3907 -867 2749 2901 3012 2541 3491 28 1931 -4476 2652 3104 2982 860 -3862 305 -1208 4067 121 -4468 -3190 -3023 2657 -2685 729 -2048 3472 2011 3811 -4638 2742 -3534 3982 -1044 -849 -2830 -944 -2649 3464 -680 -2236 -3255 3605 356 -3973 -4202 251 -3848 -3405 -1440 -2884 1155 -3706 -3034 1357 3976 2112 -2613 4520 83 277 415 -843 2311 4505 2078 2894"
	# ps $ARG
	
	# ## Test - 500 random
	# ARG="-201 1122 -2024 -2556 194 -2487 3859 -4960 -2695 1628 4820 -362 -3636 -1998 828 -217 -4683 -3764 912 3506 941 -4241 4893 804 -4785 4733 -1438 -2526 -868 4696 132 4076 3678 -1305 3936 3426 3852 -1068 3116 -134 -242 -760 -3311 2614 -1562 -1091 -3798 -2377 4065 466 4973 3469 3314 2563 1209 -4951 2283 3073 1947 -300 4714 -4542 -4289 4347 3697 4662 -3572 -37 -2618 -3568 -1569 3701 -1920 -936 -3565 901 -4190 3356 -944 1643 -790 1772 2705 4466 4396 -3760 2675 3736 889 855 -4998 3744 -4767 3355 326 94 2778 3899 -4412 309 -3726 2379 -1052 -117 3730 3706 -202 592 1168 -1463 -4630 -2307 -4772 626 3140 643 2168 3519 -3736 -2788 4120 -1838 2769 -3074 -1220 -505 3951 -3530 -3394 -388 3661 337 4607 -668 -1295 4444 1992 -1125 1575 -3401 -1737 4109 -1522 -532 -60 1715 -4095 124 -4082 3096 989 -654 -4051 2846 -942 1558 -1510 791 4592 3599 444 4889 2989 3543 2510 380 -3683 2997 3482 512 1487 -4955 947 2070 4089 -598 994 2796 -4322 -2359 4795 -3538 -1232 -2609 2456 1277 1702 4124 -3682 -3719 -2873 -3647 -4880 -1270 2759 4262 -540 -4119 -634 1888 239 -4019 -4782 -2737 -3447 -1077 -1521 1401 2481 1630 -2477 4011 2995 3249 1441 3448 1907 4664 1938 421 -2334 86 4052 -3164 -2242 -2002 2112 -4526 -428 3238 -3119 42 3580 -2338 173 -1974 1821 1087 784 2644 -4124 3473 3246 1032 2132 -798 305 4000 379 3398 -2922 -728 -4438 -4563 2222 4599 4393 -2017 -1142 1798 859 1933 2399 -571 3642 -415 1382 -2614 360 4439 -1230 -3428 -2651 -3350 4349 -3441 -4021 4492 -3528 -716 168 3562 -3489 -2912 3087 4833 453 806 1669 -4431 811 -3001 2362 -888 2907 55 -2315 -1777 365 -1561 2517 734 -3219 -4133 4394 -72 1010 -128 4153 -1204 581 -2766 -4539 2205 -4056 -1496 -2221 1408 2781 -2858 3677 1460 1748 -1504 -3581 -2486 406 -3651 -970 4445 2604 1359 -2787 4218 1773 -398 -4267 2018 2745 -54 -1390 849 3878 -1176 -2805 2492 927 2029 1871 -3878 3168 2249 -1432 3722 -1466 1059 1698 3820 4750 -3146 4134 3798 -3849 88 100 1523 2087 -4965 1452 553 745 -3182 -286 -1505 602 3888 -3232 -996 -2069 -2521 -3140 663 484 -4221 149 -4862 -1646 -958 4363 -3291 4744 161 -1983 3190 603 -2403 -4562 -2401 -3175 -1475 -4961 -1772 -2968 443 -1659 209 -4593 -14 -1024 2668 -3193 -4868 -1212 4225 -1826 3934 -2594 3651 3718 702 -1548 4019 -52 -1225 1411 519 -4350 540 2805 566 -3118 -3296 -3621 1508 -447 -1434 -3421 1439 -558 -4419 576 -3113 -1310 -1975 629 -1047 1511 1754 557 1147 4166 1800 2768 3245 2631 -646 2870 4432 -3580 4207 2426 2110 -1470 1397 1954 2054 1081 1227 -1636 3333 4763 1533 3365 -1393 -3933 -1780 4258 -2589 -1177 480 -2760 -3557 1885 3290 -1588 178 624 -3974 -4233 1248 1741 -466 -758 -175 2627 1678 165 493 -2658 1967"
	# ps $ARG

	# ARG="1003 -216 -3695 -4332 -419 -87 -447"
	# ps $ARG

	ARG="hallo 2 3"
	check_error $ARG

	echo -e "
	${DONE}Finished!${DEF}
	"
fi


#====================================
# Eval Sheet Tests
if [[ $tests == "1" ]]; then
	#====================================
	# Identity Test
	echo ""
	echo -e "${BLUE}Identity Test"
	echo -e "-------------${DEF}"

	## Test 1 - 42
	ARG="42"
	# run $ARG
	# check $ARG
	ps $ARG


	## Test 2 - 0 1 2 3
	ARG="0 1 2 3"
	ps $ARG


	## Test 3 -  0 1 2 3 4 5 6 7 8 9
	ARG="0 1 2 3 4 5 6 7 8 9"
	ps $ARG


	#====================================
	# Simple Version
	echo -e "${BLUE}Simple Version"
	echo -e "--------------${DEF}"

	## Test 1 - 2 1 0
	ARG="2 1 0"
	ps $ARG


	#====================================
	# Another Simple Version
	echo -e "${BLUE}Another Simple Version"
	echo -e "----------------------${DEF}"

	## Test 1 - 1 5 2 4 3
	ARG="1 5 2 4 3"
	ps $ARG


	## Test 2 - 5 random values
	generate_random 5
	ARG="$rand_nb"
	ps $ARG


	# #====================================
	# # Middle Version
	echo -e "${BLUE}Middle Version - 100 random values"
	echo -e "----------------------------------${DEF}"

	# Test 1 - 100 random values
	ARG="-1273 3053 -3710 376 4275 2339 -4846 3489 -508 146 1763 -3434 -1837 2172 -1672 -42 3287 455 271 1636 -2479 -1134 440 -1896 202 -3698 -4422 4021 2430 3258 3898 -901 -124 3646 939 -2323 3586 -19 -4402 803 1754 -3244 -3272 -579 -1370 4738 -3859 -2888 -4876 3138 -4721 -2002 2167 4573 -2364 1393 2858 1601 1497 2118 3499 1081 1056 4927 1789 -1603 3036 4725 1802 336 3757 -3198 -872 3676 -1393 4384 -4753 2388 584 846 -4442 2002 2147 643 483 487 2085 -641 2461 -1366 4720 3969 1816 3953 2341 -3975 -3194 1687 3285 2891"
	ps $ARG


	#====================================
	# Advanced Version
	echo -e "${BLUE}Advanced Version - 500 random values"
	echo -e "------------------------------------${DEF}"

	## Test 1 - 500 random values
	ARG="-2471 3494 1046 -1307 2909 1087 -1726 -3273 690 4058 -2867 -2975 2880 3334 1863 559 397 881 2093 32 624 2171 -127 -1695 -752 -887 -3610 3666 -3306 -4450 -2718 -2592 3454 3840 2107 3182 -1045 -3983 -2807 2843 4227 -2806 1800 -4549 -4583 1664 4750 -2154 -4049 -893 -2948 287 -3233 -3242 -950 210 1804 2689 -3431 -462 -562 -3598 306 -4178 409 -1774 -3714 2825 1145 -1424 1709 4666 4816 -4350 -1639 4357 -660 1462 -4230 2361 2005 345 -4700 -2595 4197 2154 3399 -916 -2565 -411 1898 4473 -222 -1430 -27 1035 4759 -2694 2179 3694 1295 1463 -2443 4251 2034 -1182 -652 -3624 2157 -523 -515 -2850 -1242 4385 -114 1271 -4774 -331 4904 3044 1154 -4270 -3832 -437 3972 -214 -4793 1224 -1815 4919 1627 -2207 -628 4562 -983 4048 2134 -3580 4893 2833 1440 -2129 -3020 1293 -4395 1809 4864 764 -143 -1274 -3647 1142 -2643 4376 1527 1697 -2347 -3677 -522 69 1822 4200 4073 1590 2528 -928 -3836 3323 -4104 -862 4836 -4801 -1647 1841 3540 4643 2840 -3093 -4423 -1741 -1876 4377 -4334 -3510 173 3416 597 2948 -2425 -1225 -4052 798 15 2563 2124 -3814 -296 -3518 4161 -945 -4629 -3888 -3640 -3427 4676 -2578 -1300 719 -3421 2183 -4474 -775 -163 -3117 -1925 2821 1497 2845 -4554 -1878 -848 -366 2097 4587 3628 1461 -4657 -2715 1761 4143 4301 1561 -4003 1403 2418 1189 1914 -908 4681 -3165 4430 -620 -842 -958 -1985 -4335 -861 -603 -2925 -4751 3919 -3912 349 -3863 2987 -2366 -3098 -4685 3042 -3630 288 -4019 -132 -2405 638 310 -85 -1688 -4338 3406 2624 2822 2906 4215 290 -449 2317 -2419 366 133 4716 4769 -4616 2846 127 2312 3073 598 -2923 -2265 464 -4817 -1907 3928 1820 -1609 4746 -385 -2198 486 -2153 -4913 -4051 791 1133 905 2777 -4969 -2943 -1299 -2131 -2015 2138 1187 -4646 -1917 4451 -1607 2443 1015 -2098 240 2300 -1222 3306 -2168 -3521 2630 922 -572 4648 28 -2638 2785 2353 4591 1456 864 1161 -2038 -4236 4057 -4358 4259 -4007 -1870 -1084 4271 2151 1483 -1693 1399 2295 777 3164 1370 1131 -2104 3033 4222 -3930 -38 1240 -4149 2304 -4244 1958 2973 2882 3045 -1928 154 -1463 1969 0 -2580 68 3581 2716 -2627 -625 -4209 -28 2088 -3005 -1552 -3173 17 3303 -3653 -4707 -3207 1166 1905 4594 -4677 -1125 4232 -493 1537 -2939 3457 -3532 3483 1695 2049 1492 -1755 1677 -3704 3562 1491 3645 874 -1806 -438 -2579 -4777 1250 1658 2896 4539 -618 2701 -4566 2190 2796 906 1264 2409 1400 615 -2637 118 -1881 -4237 -553 -3740 3876 4702 -4117 3405 -3728 4278 817 2092 -2458 2930 4766 246 1321 -2177 -4798 2437 -346 -1026 1417 662 -4276 -4018 -4666 -4888 -457 -1770 3994 -727 2509 1916 -3794 4764 2604 -3810 -4955 3647 -551 3046 3390 3743 3847 2603 -1704 433 -317 3304 3707 806 -4456 3841 -2320 2774 19 -1853 -295 -1841 1961 1394 1328 -4838 2261 343"
	ps $ARG

fi


#====================================
# My Tests
if [[ $tests == "0" ]]; then
	echo ""
	echo -e "${BLUE}My Tests"
	echo -e "-------------${DEF}"

	## Test 1 - 42
	ARG="42"
	ps $ARG

	## Test 2 - 1 0 [1/2]
	ARG="1 0"
	ps $ARG

	## Test 3 -  0 1 [2/2]
	ARG="0 1"
	ps $ARG

	## Test 4 -  0 1 2 [1/6]
	ARG="0 1 2"
	ps $ARG

	## Test 5 -  0 2 1 [2/6]
	ARG="0 2 1"
	ps $ARG

	## Test 6 -  1 0 2 [3/6]
	ARG="1 0 2"
	ps $ARG
	## Test 7 -  1 2 0 [4/6]
	ARG="1 2 0"
	ps $ARG

	## Test 8 -  2 0 1 [5/6]
	ARG="2 0 1"
	ps $ARG

	## Test 9 -  2 1 0 [6/6]
	ARG="2 1 0"
	ps $ARG

	## Test 10 - Not int
	ARG="1 hallo 2"
	check_error $ARG

	## Test 11 - Bigger than int
	ARG="1 999999999999999999 2"
	check_error $ARG

	## Test 12 - Smaller than int
	ARG="1 -999999999999999999 2"
	check_error $ARG

	## Test 13 - Duplicates
	ARG="1 2 2"
	check_error $ARG

	## Test 14 - No input
	ARG="     "
	check_error $ARG

	## Test 15 - Weird input
	ARG="-+10 --7 +-5"
	check_error $ARG

	## Test 16 -  3 2 1 0
	ARG="3 2 1 0"
	ps $ARG

	## Test - 5 random
	generate_random 5
	ARG="$rand_nb"
	ps $ARG

	## Test - 100 random
	ARG="1003 -216 -3695 -4332 -419 -87 -447 -3969 -2358 4448 2778 -2406 2801 -3668 -3417 4102 2366 4316 1561 -1567 238 4573 1870 4747 486 1354 -1737 379 628 1594 -3141 245 1940 3907 -867 2749 2901 3012 2541 3491 28 1931 -4476 2652 3104 2982 860 -3862 305 -1208 4067 121 -4468 -3190 -3023 2657 -2685 729 -2048 3472 2011 3811 -4638 2742 -3534 3982 -1044 -849 -2830 -944 -2649 3464 -680 -2236 -3255 3605 356 -3973 -4202 251 -3848 -3405 -1440 -2884 1155 -3706 -3034 1357 3976 2112 -2613 4520 83 277 415 -843 2311 4505 2078 2894"
	ps $ARG
	
	## Test - 500 random
	ARG="-201 1122 -2024 -2556 194 -2487 3859 -4960 -2695 1628 4820 -362 -3636 -1998 828 -217 -4683 -3764 912 3506 941 -4241 4893 804 -4785 4733 -1438 -2526 -868 4696 132 4076 3678 -1305 3936 3426 3852 -1068 3116 -134 -242 -760 -3311 2614 -1562 -1091 -3798 -2377 4065 466 4973 3469 3314 2563 1209 -4951 2283 3073 1947 -300 4714 -4542 -4289 4347 3697 4662 -3572 -37 -2618 -3568 -1569 3701 -1920 -936 -3565 901 -4190 3356 -944 1643 -790 1772 2705 4466 4396 -3760 2675 3736 889 855 -4998 3744 -4767 3355 326 94 2778 3899 -4412 309 -3726 2379 -1052 -117 3730 3706 -202 592 1168 -1463 -4630 -2307 -4772 626 3140 643 2168 3519 -3736 -2788 4120 -1838 2769 -3074 -1220 -505 3951 -3530 -3394 -388 3661 337 4607 -668 -1295 4444 1992 -1125 1575 -3401 -1737 4109 -1522 -532 -60 1715 -4095 124 -4082 3096 989 -654 -4051 2846 -942 1558 -1510 791 4592 3599 444 4889 2989 3543 2510 380 -3683 2997 3482 512 1487 -4955 947 2070 4089 -598 994 2796 -4322 -2359 4795 -3538 -1232 -2609 2456 1277 1702 4124 -3682 -3719 -2873 -3647 -4880 -1270 2759 4262 -540 -4119 -634 1888 239 -4019 -4782 -2737 -3447 -1077 -1521 1401 2481 1630 -2477 4011 2995 3249 1441 3448 1907 4664 1938 421 -2334 86 4052 -3164 -2242 -2002 2112 -4526 -428 3238 -3119 42 3580 -2338 173 -1974 1821 1087 784 2644 -4124 3473 3246 1032 2132 -798 305 4000 379 3398 -2922 -728 -4438 -4563 2222 4599 4393 -2017 -1142 1798 859 1933 2399 -571 3642 -415 1382 -2614 360 4439 -1230 -3428 -2651 -3350 4349 -3441 -4021 4492 -3528 -716 168 3562 -3489 -2912 3087 4833 453 806 1669 -4431 811 -3001 2362 -888 2907 55 -2315 -1777 365 -1561 2517 734 -3219 -4133 4394 -72 1010 -128 4153 -1204 581 -2766 -4539 2205 -4056 -1496 -2221 1408 2781 -2858 3677 1460 1748 -1504 -3581 -2486 406 -3651 -970 4445 2604 1359 -2787 4218 1773 -398 -4267 2018 2745 -54 -1390 849 3878 -1176 -2805 2492 927 2029 1871 -3878 3168 2249 -1432 3722 -1466 1059 1698 3820 4750 -3146 4134 3798 -3849 88 100 1523 2087 -4965 1452 553 745 -3182 -286 -1505 602 3888 -3232 -996 -2069 -2521 -3140 663 484 -4221 149 -4862 -1646 -958 4363 -3291 4744 161 -1983 3190 603 -2403 -4562 -2401 -3175 -1475 -4961 -1772 -2968 443 -1659 209 -4593 -14 -1024 2668 -3193 -4868 -1212 4225 -1826 3934 -2594 3651 3718 702 -1548 4019 -52 -1225 1411 519 -4350 540 2805 566 -3118 -3296 -3621 1508 -447 -1434 -3421 1439 -558 -4419 576 -3113 -1310 -1975 629 -1047 1511 1754 557 1147 4166 1800 2768 3245 2631 -646 2870 4432 -3580 4207 2426 2110 -1470 1397 1954 2054 1081 1227 -1636 3333 4763 1533 3365 -1393 -3933 -1780 4258 -2589 -1177 480 -2760 -3557 1885 3290 -1588 178 624 -3974 -4233 1248 1741 -466 -758 -175 2627 1678 165 493 -2658 1967"
	ps $ARG

	echo -e "
	${DONE}Finished!${DEF}
	"

fi


#====================================
# Checker bonus
if [[ $tests == "3" ]]; then

	# Check for checker executable
	if [[ -f checker_bonus/checker ]]; then
		checker="./checker"
	else
		echo -e "${RED}ERROR${DEF}: No checker executable found."
		exit 1
	fi

	cd checker_bonus/
	echo ""
	echo -e "${BLUE}Checker Program - Error Management"
	echo -e "--------------------------------${DEF}"

	## Test 1 - Non numeric => KO
	ARG="hallo un deux"
	run_c $ARG

	## Test 2 - Duplicates => KO
	ARG="1 3 1"
	run_c $ARG

	## Test 3 - Greater than MAX_INT => KO
	ARG="1 9999999999999999999 1"
	run_c $ARG

	## Test 4 - Greater than MAX_INT => nothing + give prompt back
	ARG=""
	run_c $ARG

	## Test 5 - Valid parameters + incorrect operation => KO
	ARG="1 3 2"
	run_c $ARG

	## Test 6 - Valid parameters + operation w/ one or several spaces before/after the instruction phase => KO
	ARG="1 4 2"
	run_c $ARG

	echo ""
	echo -e "${BLUE}Checker Program - False Tests"
	echo -e "-----------------------------${DEF}"

	## Test 1 - Given valid list of operations => KO
	ARG="0 9 1 8 2 7 3 6 4 5"
	run_c $ARG

	## Test 2 - Choose valid parameters + valid instruction list that does NOT order => KO
	ARG="0 9 1 8 2 7 3 6 4 5"
	run_c $ARG

	echo ""
	echo -e "${BLUE}Checker Program - Right Tests"
	echo -e "-----------------------------${DEF}"

	## Test 1 - Without any instruction => OK
	ARG="0 1 2"
	run_c $ARG

	## Test 2 - Given valid action list => OK
	ARG="0 9 1 8 2"
	run_c $ARG

	## Test 3 - Choose valid parameters + valid instructions that order => OK
	ARG="0 3 2"
	run_c $ARG
	
	echo -e "
	${DONE}Finished!${DEF}
	"
fi