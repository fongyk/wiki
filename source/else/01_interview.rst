复习
=========

汇总
----------
1. github

  - https://github.com/imhuay/Algorithm_Interview_Notes-Chinese

  - https://github.com/jwasham/coding-interview-university/blob/master/translations/README-cn.md

2. 2018校招算法岗面试题汇总

  https://zhuanlan.zhihu.com/p/36801851

编程算法
------------
1. 动态规划

  - 有面值1,5,10,20,50,100的人民币，求问10000有多少种组成方法？

      https://www.zhihu.com/question/315108379

  - 如何用最少的次数测出鸡蛋会在哪一层摔碎？

      https://www.zhihu.com/question/19690210

  - [LeetCode] Maximum Product Subarray 求连续子数组的最大乘积

      https://blog.csdn.net/xblog\_/article/details/72872263

2. 排序算法之桶排序

  https://blog.csdn.net/developer1024/article/details/79770240

3. 找出数组中N个出现1（或奇数次）次的数字

  https://www.jianshu.com/p/e1331664c8cf

4. 均匀分布生成其他分布的方法

  https://blog.csdn.net/haolexiao/article/details/60511164

5. 海量数据处理

  - 面试题集锦

      https://blog.csdn.net/v_july_v/article/details/6685962

  - 大文件中返回频数最高的100个词

      https://blog.csdn.net/tiankong\_/article/details/77240283

6. 链表

  - 求有环单链表中的环长、环起点、链表长

      https://www.cnblogs.com/xudong-bupt/p/3667729.html

  - 判断两个链表是否相交并找出交点

      https://blog.csdn.net/jiary5201314/article/details/50990349

  - 单链表 :math:`\mathcal{O}(1)` 时间删除给定节点

      https://blog.csdn.net/qq_35546040/article/details/80341136

7. 全排列的非递归和递归实现（含重复元素）。Hint：在交换第 :math:`i` 个元素与第 :math:`j` 个元素之前，要求数组的 :math:`[i, j)` 区间中的元素没有与第 :math:`j` 个元素重复。

  https://blog.csdn.net/so_geili/article/details/71078945

8. 排列组合：:math:`k` 个球放入 :math:`m` 个盒子

  https://blog.csdn.net/qwb492859377/article/details/50654627?tdsourcetag=s_pctim_aiomsg

9. Next Permutation 下一个排列

  https://www.cnblogs.com/grandyang/p/4428207.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      // 从后往前先找到第一个开始下降的数字x（下标i），再从后往前找到第一个比x大的数y（下标j）；交换x，y；翻转区间 [i+1, end)。
      class Solution
      {
      public:
          void nextPermutation(vector<int> &num)
          {
              int i, j, n = num.size();
              for (i = n - 2; i >= 0; --i)
              {
                  if (num[i + 1] > num[i])
                  {
                      for (j = n - 1; j > i; --j)
                      {
                          if (num[j] > num[i]) break;
                      }
                      swap(num[i], num[j]);
                      reverse(num.begin() + i + 1, num.end());
                      return;
                  }
              }
              reverse(num.begin(), num.end()); // 当前排列是最大的排列，则翻转为最小的排列
          }
      };


10. LeetCode 75. Sort Colors（三颜色排序→K颜色排序）

  https://blog.csdn.net/princexiexiaofeng/article/details/79645511

11. 找到数组第 :math:`k` 大的数

  https://leetcode.com/problems/kth-largest-element-in-an-array/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:
      :emphasize-lines: 7,8,14,15,24,25,28,29

      class Solution
      {
      public:
          int partition(vector<int>& nums, int i, int j)
          {
              int pivot = nums[i];
              int l = i+1;
              int r = j;
              while(true)
              {
                  while(l<=j && nums[l]<pivot) l++;
                  while(r>i && nums[r]>pivot) r--;
                  if(l>=r) break;
                  swap(nums[l], nums[r]);
                  l++;
                  r--;
              }
              swap(nums[i], nums[r]);
              return r;
          }
          // partition 可用如下更简洁的形式
          int partition(vector<int>& nums, int i, int j)
          {
              int pivot = nums[i];
              int l = i;
              int r = j+1;
              while(true)
              {
                  while(nums[++l]<pivot && l<j);
                  while(nums[--r]>pivot);
                  if(l>=r) break;
                  swap(nums[l], nums[r]);
              }
              swap(nums[i], nums[r]);
              return r;
          }

          // T(n) = 2T(n/2) + O(n)，时间复杂度 O(N)
          int quicksort(vector<int>& nums, int a, int b, int k)
          {
              int p = partition(nums, a, b);
              if(b - p + 1 == k) return p;
              if(b - p + 1 < k) return quicksort(nums, a, p-1, k - (b - p + 1));
              else return quicksort(nums, p+1, b, k);
          }
          int findKthLargest(vector<int>& nums, int k)
          {
              int k_id = quicksort(nums, 0, nums.size()-1, k);
              return nums[k_id];
          }
      };



12. [LeetCode] Best Time to Buy and Sell Stock 买卖股票的最佳时间

  - 最多一次交易

      http://www.cnblogs.com/grandyang/p/4280131.html

  - 无限次交易

      http://www.cnblogs.com/grandyang/p/4280803.html

  - 最多两次交易

      http://www.cnblogs.com/grandyang/p/4281975.html

  - 最多k次交易

      http://www.cnblogs.com/grandyang/p/4295761.html

      https://blog.csdn.net/linhuanmars/article/details/23236995

  - 交易冷却

      https://www.cnblogs.com/grandyang/p/4997417.html

13. [LeetCode] Partition Equal Subset Sum 数组分成两个子集，和相等

  https://leetcode.com/problems/partition-equal-subset-sum/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: python
      :linenos:
      :emphasize-lines: 2,7,9,23

      class Solution(object):
      def backtrack(self, nums, sum_nums, sum_current, i): ## self
          if sum_current == sum_nums/2:
              return True
          if i == len(nums):
              return False
          if self.backtrack(nums, sum_nums, sum_current+nums[i],i+1): ## self
              return True
          if self.backtrack(nums, sum_nums, sum_current, i+1): ## self
              return True
          return False

      def canPartition(self, nums):
          """
          :type nums: List[int]
          :rtype: bool
          """
          if len(nums) <= 1:
              return False
          sum_nums = sum(nums)
          if sum_nums % 2:
              return False
          return self.backtrack(nums, sum_nums, 0, 0) ## self


14. [LeetCode] Find All Anagrams in a String 统计变位词出现的位置。Hint：采用滑动窗口和 **计数器** 进行比较。

  https://leetcode.com/problems/find-all-anagrams-in-a-string/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      /* https://leetcode.com/problems/find-all-anagrams-in-a-string/discuss/92027/C%2B%2B-O(n)-sliding-window-concise-solution-with-explanation */

      class Solution
      {
      public:
          vector<int> findAnagrams(string s, string p)
          {
              vector<int> vec;
              if(s.size()<p.size() || (s.empty() && p.empty())) return vec;
              vector<int> p_counter(26, 0), s_counter(26, 0);
              for(int i = 0; i < p.size(); ++i)
              {
                  ++ p_counter[p[i]-'a'];
                  ++ s_counter[s[i]-'a'];
              }
              if(p_counter == s_counter) vec.push_back(0);
              for(int i = p.size(); i < s.size(); ++i)
              {
                  -- s_counter[s[i-p.size()]-'a'];
                  ++ s_counter[s[i]-'a'];
                  if(s_counter == p_counter) vec.push_back(i-p.size()+1);
              }
              return vec;
          }
      };


15. [LeetCode] Find the Duplicate Number 寻找重复数。数值范围为 :math:`\{ 1,2,3,...,n \}` 。Hint：把数组元素的值当做下标，由于元素存在重复，因此必然会 **重复多次访问同一个位置** 。
从另一个角度讲，访问序列中存在“环”。哈希不满足空间复杂度为 :math:`\mathcal{O}(1)` 的要求。

  - 找到一个重复数字。

      http://www.cnblogs.com/grandyang/p/4843654.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      // 解法一：快慢指针，寻找某个“环”的入口
      class Solution
      {
      public:
          int findDuplicate(vector<int>& nums)
          {
              int slow = 0, fast = 0, t = 0;
              while (true)
              {
                  slow = nums[slow];
                  fast = nums[nums[fast]];
                  if (slow == fast) break;
              }
              while (true)
              {
                  slow = nums[slow];
                  t = nums[t];
                  if (slow == t) break;
              }
              return slow;
          }
      };

      // 解法二：不断交换位置，找到第一个重复访问的元素
      class Solution
      {
      public:
          int findDuplicate(vector<int>& nums)
          {
              int duplicate;
              for(int k = 0; k < nums.size(); ++k)
              {
                  while(nums[k]-1 != k)
                  {
                      if(nums[k] == nums[nums[k]-1])
                      {
                          duplicate = nums[k];
                          break;
                      }
                      swap(nums[k], nums[nums[k]-1]);
                      // 一次交换之后，下标为 nums[k]-1 的元素就等于 nums[k] 了。
                  }
              }
              return duplicate;
          }
      };


  - 找到所有重复数字。

      http://www.cnblogs.com/grandyang/p/6209746.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      // 解法一：将访问过的元素置为相反数（负数），如果下次访问到一个负数，说明这个元素被重复访问
      class Solution
      {
      public:
          vector<int> findDuplicates(vector<int>& nums)
          {
              vector<int> res;
              for (int i = 0; i < nums.size(); ++i)
              {
                  int idx = abs(nums[i]) - 1;
                  if (nums[idx] < 0) res.push_back(idx + 1);
                  else nums[idx] = -nums[idx];
              }
              return res;
              // 这种方法得到的 res 可能多次包含同一个元素，可以使用 set
          }
      };

      // 解法二：不断交换位置使得 i == nums[i]-1
      class Solution
      {
      public:
          vector<int> findDisappearedNumbers(vector<int>& nums)
          {
              vector<int> disappear;
              if(nums.size()<=1) return disappear;
              for(int k = 0; k < nums.size(); ++k)
              {
                  while(nums[k] != nums[nums[k]-1]) swap(nums[k], nums[nums[k]-1]);
              }
              for(int k = 0; k < nums.size(); ++k)
              {
                  if(nums[k]-1 != k) disappear.push_back(nums[k]);
              }
              return disappear;
          }
      };


16. [LeetCode] Spiral Matrix 环形打印矩阵

  https://leetcode.com/problems/spiral-matrix/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          void tranverseMatrixAccorindTo4Directions(vector<vector<int>> &matrix, const unsigned int row, const unsigned int col, int start, vector<int>& vec)
          {
              // 特别注意
              // 如果把 start, endX, endY, k 声明为 unsigned int 类型，在减到 0 的时候可能会死循环，因为 unsigned int 类型不会小于 0。

              int endX = row-1 - start;
              int endY = col-1 - start;

              // 1 向右
              for(int k = start; k <= endY; ++k) vec.push_back(matrix[start][k]);

              // 2 向下
              for(int k = start+1; k <= endX; ++k) vec.push_back(matrix[k][endY]);

              // 3 向左：要求至少存在两行（不加判断会重复扫描同一行）
              if(endX > start) for(int k = endY-1; k >= start; --k) vec.push_back(matrix[endX][k]);

              // 4 向上：要求至少存在两列（不加判断会重复扫描同一列）
              if(endY > start) for(int k = endX-1; k > start; --k) vec.push_back(matrix[k][start]);

          }
          vector<int> spiralOrder(vector<vector<int>>& matrix)
          {
              vector<int> vec;
              unsigned int row = matrix.size();
              if(row == 0) return vec;
              unsigned int col = matrix[0].size();
              if(col == 0) return vec;
              int start = 0;
              // 循环中止条件：圈数判断（ (start,start) 是每一圈的入口坐标）
              while(start*2 < row && start*2 < col)
              {
                  tranverseMatrixAccorindTo4Directions(matrix, row, col, start, vec);
                  ++ start;
              }
              return vec;
          }
      };


17. [LeetCode] Longest Consecutive Sequence 最长连续序列。Hint：方法一，排序；方法二，对于每个元素 :math:`n` ，搜索 :math:`n+1` 是否在数组中，使用 hash（set）可以获得 :math:`\mathcal{O}(1)` 的查找复杂度。

  https://leetcode.com/problems/longest-consecutive-sequence/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      class Solution(object):
      def longestConsecutive(self, nums):
          """
          :type nums: List[int]
          :rtype: int
          """

          longest = 0
          num_set = set(nums)

          for num in nums:
              if num-1 not in num_set:
                  current_long = 1
                  while num + 1 in num_set:
                      current_long += 1
                      num += 1
                  longest = max(longest, current_long)

          num_set.clear()

          return longest


18. 最小公约数与最大公倍数。Hint：辗转相除法；最大公倍数等于两数乘积除以最大公约数。

  https://www.cnblogs.com/Arvin-JIN/p/7247619.html

19. 跳跃的蚂蚱：从 0 点出发，往正或负向跳跃，第一次跳跃一个单位，之后每次跳跃距离比上一次多一个单位，跳跃多少次可到到达坐标 :math:`x` 处？
Hint：走 :math:`n` 步之后能到达的坐标是一个差为 2 的等差数列（如 :math:`n=3` ，可到达 :math:`\{-3,-1,1,3\}` ）。
只需找到第最小的 :math:`n` 使得

.. math::

  (1+2+...+n) - x = \frac{n(n+1)}{2} - x

是非负偶数。跳到 :math:`x` 和跳到 :math:`-x` 的次数相同，
因此只考虑 :math:`x` 为正的情况。

  https://www.zhihu.com/question/50790221

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      // 作者：Rukia
      // 链接：https://www.zhihu.com/question/50790221/answer/125213696

      int minStep(int x)
      {
      	if (x==0) return 0;
      	if (x<0) x=-x;
      	int n=sqrt(2*x); // 快速找到一个接近答案的 n
      	while ((n+1)*n/2-x & 1 || (n+1)*n/2 < x) // & 的优先级低
      		++n;
      	return n;
      }


20. 求 :math:`n` 的阶乘末尾有多少个 :math:`0` 。Hint：1个 :math:`5` 和1个 :math:`2` 搭配可以得到1个 :math:`0` ；:math:`2` 的个数比 :math:`5` 多，
因此只关心 :math:`5` 的个数；:math:`25` 包含2个 :math:`5` ，:math:`125` 包含3个 :math:`5` ...。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int trailingZeroes(int n)
          {
              if(n <= 0) return 0;
              int res = 0;
              while(n)
              {
                  res += n / 5;
                  n /= 5;
              }
              return res;
          }
      };


21. 求一个整数的二进制表示中 :math:`1` 的个数。Hint：移位操作，负数可能造成死循环。 **注：指定移位次数大于或等于对象类型的比特数（如int型的32位），或者对负数进行左移操作，结果都是未定义的** 。
例如：``n >> 32`` 是未定义的，但是允许 ``n >>= 1`` 执行无限次，这是安全的。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一：不断右移n。如果n是负数，需要保持最高位为1，不断移位后这个数字会变成 0xFFFFFFFF 而陷入死循环。
      int Numberof1(int n)
      {
        int cnt = 0;
        while(n)
        {
          if(n & 1) cnt ++;
          n >>= 1;
        }
        return cnt;
      }

      // 方法二：n不动，左移一个比较子。
      int Numberof1(int n)
      {
        int cnt = 0;
        unsigned int flag = 1;
        while(flag) // 连续左移32次之后为0
        {
          if(n & flag) cnt ++;
          flag <<= 1;
        }
        return cnt;
      }

      // 方法三：把一个整数减1，再和原整数做逻辑与运算，会把该整数最右边的一个1变成0。
      int Numberof1(int n)
      {
        int cnt = 0;
        while(n)
        {
          cnt ++;
          n = (n - 1) & n;
        }
        return cnt;
      }


22. [LeetCode] Subarray Sum Equals K 子数组和为 :math:`K` 。Hint：依次求数组的前 :math:`n` 项和 :math:`sum[n]` ，:math:`n \in [0, arr\_size]` （注意：0也在内），
将和作为哈希表的key，和的值出现次数作为value；如果存在 :math:`sum[i]−sum[j]=K \ (i \ge j)` ，则 :math:`sum[i]` 和 :math:`sum[j]` 都应该在哈希表中。

  https://leetcode.com/problems/subarray-sum-equals-k/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      // https://leetcode.com/problems/subarray-sum-equals-k/solution/ : Approach #4 Using hashmap

      from collections import defaultdict
      class Solution(object):
      def subarraySum(self, nums, k):
          """
          :type nums: List[int]
          :type k: int
          :rtype: int
          """

          if len(nums) == 0:
              return 0

          N = len(nums)

          sum_to_num = defaultdict(int)
          sum_to_num[0] = 1 // 前 0 项和

          cnt = 0
          tmp_sum = 0
          for n in nums:
              tmp_sum += n
              diff = tmp_sum - k
              cnt += sum_to_num[diff]
              sum_to_num[tmp_sum] += 1

          return cnt


23. 使用位运算进行加法运算。Hint：原位加法运算等效为 ``^`` 运算，进位等效为 ``&`` 和 ``移位`` 的复合。 **注：C++不允许对负数进行左移运算。**

  https://leetcode.com/problems/sum-of-two-integers/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Show/Hide\ Code}`

    .. code-block:: cpp
      :linenos:

      class Solution {
      public:
          int getSum(int a, int b) {
              int sum, carry;
              do
              {
                  sum = (a ^ b);
                  carry = (a & b & INT_MAX) << 1; // & INT_MAX 操作保证移位前的数是正数，否则结果是未定义的。
                  a = sum;
                  b = carry;
              }while(b != 0);
              return a;
          }
      };

    .. code-block:: python
      :linenos:

      from numpy import int32

      class Solution(object):
          def getSum(self, a, b):
              """
              :type a: int
              :type b: int
              :rtype: int
              """
              a, b = int32(a), int32(b)

              while True:
                  a, b = a ^ b, (a & b) << 1
                  print a, b
                  if b == 0:
                      break

              return int(a)

      ## 注意，这里并没有与 0x7fffffff 做 & 运算
      ## 假设 a & b = -16，-16 & 0x7fffffff = 2147483632
      ## C++ 中，对 2147483632 左移1位使得最高位符号位为 1，得到 -32
      ## python中，2147483632的符号位为 0，继续左移1位，会直接做大整数运算，得到 4294967264L，导致不能得到正确结果
      ## python 中，使用type()查看数据类型时发现，有时候系统会把 int32 转化为 int64，或者 int64 转为 int32，疑惑中。。。



C++
------------

1. 虚函数

  https://blog.csdn.net/fighting_coder/article/details/77187151

2. C++构造函数和析构函数能否声明为虚函数？(转载)

  https://www.cnblogs.com/hxb316/p/3853544.html

3. 重载、重写（覆盖）和隐藏的区别

  https://blog.csdn.net/zx3517288/article/details/48976097

4. C++ STL中vector内存用尽后，为啥每次是两倍的增长，而不是3倍或其他数值？

  https://www.zhihu.com/question/36538542

Python
-----------

1. 基本数据类型

  https://www.cnblogs.com/littlefivebolg/p/8982889.html

2. Python中的None

  https://www.cnblogs.com/changbaishan/p/8084863.html

3. 使用lambda高效操作列表的教程

  https://www.cnblogs.com/mxp-neu/articles/5316557.html

4. 经典7大Python面试题

  https://blog.csdn.net/qq_41597912/article/details/81459804

5. 迭代器和生成器

  https://www.cnblogs.com/chongdongxiaoyu/p/9054847.html

机器学习（深度学习）
---------------------------

1. 激活函数

  https://fongyq.github.io/blog/deepLearning/02_activationFunction.html

2. Batch Normalization

  https://fongyq.github.io/blog/deepLearning/03_batchnorm.html

3. 过拟合

  https://fongyq.github.io/blog/deepLearning/03_batchnorm.html

4. 正则化项L1和L2的区别

  https://www.cnblogs.com/lyr2015/p/8718104.html

5. KMeans秘籍之如何确定K值

  https://blog.csdn.net/alicelmx/article/details/80991870

6. 决策树

  - ID3、C4.5

      https://www.cnblogs.com/coder2012/p/4508602.html

  - 预剪枝与后剪枝

      https://blog.csdn.net/zfan520/article/details/82454814

  - CART分类与回归树

      https://www.jianshu.com/p/b90a9ce05b28

7. Logistic Regression

  https://fongyq.github.io/blog/machineLearning/01_lr.html

8. Support Vector Machine

  https://fongyq.github.io/blog/machineLearning/02_svm.html

9. PCA

  https://fongyq.github.io/blog/machineLearning/03_pca.html


论文相关
-----------------

1. AlexNet/VGG/GoogleNet

  https://blog.csdn.net/gdymind/article/details/83042729

2. CNN卷积神经网络\_ GoogLeNet 之 Inception(V1-V4)

  https://www.cnblogs.com/haiyang21/p/7243200.html

3. R-CNN系列

  - 【RCNN系列】【超详细解析】

      https://blog.csdn.net/amor_tila/article/details/78809791

  - 实例分割模型Mask R-CNN详解：从R-CNN，Fast R-CNN，Faster R-CNN再到Mask R-CNN

      https://blog.csdn.net/jiongnima/article/details/79094159

  - RCNN（三）：Fast R-CNN

      https://blog.csdn.net/u011587569/article/details/52151871

4. CapsuleNet解读

  https://blog.csdn.net/u013010889/article/details/78722140/


其他
--------------

1. 理解数据库的事务，ACID，CAP和一致性

  https://www.jianshu.com/p/2c30d1fe5c4e
