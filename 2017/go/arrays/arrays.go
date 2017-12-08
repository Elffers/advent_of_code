package arrays

func Max(nums []int) (max int) {
	for _, num := range nums {
		if num > max {
			max = num
		}
	}
	return max
}

func Min(nums []int) int {
	min := nums[0]
	for _, num := range nums {
		if num < min {
			min = num
		}
	}
	return min
}
