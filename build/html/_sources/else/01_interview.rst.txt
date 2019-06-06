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

1. 找出数组中N个出现1（或奇数次）次的数字

  https://www.jianshu.com/p/e1331664c8cf

2. 均匀分布生成其他分布的方法

  https://blog.csdn.net/haolexiao/article/details/60511164

3. 海量数据处理。Hint：哈希方法，把大文件划分成小文件，读进内存依次处理；Bitmap，用一个（或几个）比特位来标记某个元素对应的值。

  - 面试题集锦

      https://blog.csdn.net/v_july_v/article/details/6685962

  - 大文件中返回频数最高的100个词

      https://blog.csdn.net/tiankong\_/article/details/77240283

4. 链表

  - 反转链表。Hint：方法一，逐个反转；方法二，递归；方法三，使用栈保存节点的值，反向赋给所有节点。


  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      struct ListNode
      {
          int val;
          ListNode *next;
          ListNode(int x) : val(x), next(NULL) {}
      };

    .. code-block:: cpp
      :linenos:

      // 方法一，逐个反转
      ListNode* reverseList(ListNode* head)
      {
          if(head==NULL || head->next==NULL) return head;
          ListNode* newHead = head;
          ListNode* curr = head -> next;
          ListNode* post = curr -> next;
          newHead -> next = NULL;
          while(curr)
          {
              curr -> next = newHead;
              newHead = curr;
              curr = post;
              if(post) post = post -> next;
          }
          return newHead;
      }

    .. code-block:: cpp
      :linenos:

      // 方法二，递归
      ListNode* reverseList(ListNode* head)
      {
          if(head==NULL || head->next==NULL) return head;
          else{
              ListNode* newHead = reverseList(head -> next);
              head -> next -> next = head; // head 指向的下一个节点是 newHead 的最后一个节点
              head -> next = NULL;
              return newHead;
          }
      }

    .. code-block:: cpp
      :linenos:

      // 方法三，使用栈保存节点的值，占用 O(n) 额外空间
      ListNode* reverseList(ListNode* head)
      {
          if(head==NULL || head->next==NULL) return head;
          stack<int> stk;
          ListNode* p = head;
          while(p)
          {
              stk.emplace(p -> val);
              p = p -> next;
          }
          p = head;
          while(p)
          {
              p -> val = stk.top();
              stk.pop();
              p = p -> next;
          }
          return head;
      }



  - 求有环单链表中的环长、环起点、链表长。

      https://www.cnblogs.com/xudong-bupt/p/3667729.html

  - 判断两个链表是否相交并找出交点。

      https://blog.csdn.net/jiary5201314/article/details/50990349

  - 单链表 :math:`\mathcal{O}(1)` 时间删除给定节点。Hint：交换当前节点与下一个节点的值，删除下一个节点。

      https://blog.csdn.net/qq_35546040/article/details/80341136



5. 排列组合：:math:`k` 个球放入 :math:`m` 个盒子

  https://blog.csdn.net/qwb492859377/article/details/50654627?tdsourcetag=s_pctim_aiomsg


6. [LeetCode] Sort Colors（三颜色排序→K颜色排序）

  https://blog.csdn.net/princexiexiaofeng/article/details/79645511

7. 找到数组第 :math:`k` 大的数

  https://leetcode.com/problems/kth-largest-element-in-an-array/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

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

          // T(n) = T(n/2) + O(n)，时间复杂度 O(N)
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



8. [LeetCode] Best Time to Buy and Sell Stock 买卖股票的最佳时间

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

9. [LeetCode] Partition Equal Subset Sum 数组分成两个子集，和相等

  https://leetcode.com/problems/partition-equal-subset-sum/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

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


10. [LeetCode] Find All Anagrams in a String 统计变位词出现的位置。Hint：采用滑动窗口和 **计数器** 进行比较。

  https://leetcode.com/problems/find-all-anagrams-in-a-string/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

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


11. [LeetCode] Find the Duplicate Number 寻找重复数。数值范围为 :math:`\{ 1,2,3,...,n \}` 。Hint：把数组元素的值当做下标，由于元素存在重复，因此必然会 **重复多次访问同一个位置** 。
从另一个角度讲，访问序列中存在“环”。哈希不满足空间复杂度为 :math:`\mathcal{O}(1)` 的要求。

  - 找到一个重复数字。

      http://www.cnblogs.com/grandyang/p/4843654.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

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

    .. code-block:: cpp
      :linenos:

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

      :math:`\color{darkgreen}{Code}`

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

    .. code-block:: cpp
      :linenos:

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


12. [LeetCode] Spiral Matrix 环形打印矩阵

  https://leetcode.com/problems/spiral-matrix/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

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


13. [LeetCode] Longest Consecutive Sequence 最长连续序列。Hint：方法一，排序；方法二，对于每个元素 :math:`n` ，搜索 :math:`n+1` 是否在数组中，使用 hash（set）可以获得 :math:`\mathcal{O}(1)` 的查找复杂度。

  https://leetcode.com/problems/longest-consecutive-sequence/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

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


14. 最小公约数与最大公倍数。Hint：辗转相除法；最大公倍数等于两数乘积除以最大公约数。

  https://www.cnblogs.com/Arvin-JIN/p/7247619.html

15. 跳跃的蚂蚱：从 0 点出发，往正或负向跳跃，第一次跳跃一个单位，之后每次跳跃距离比上一次多一个单位，跳跃多少次可到到达坐标 :math:`x` 处？
Hint：走 :math:`n` 步之后能到达的坐标是一个差为 2 的等差数列（如 :math:`n=3` ，可到达 :math:`\{-3,-1,1,3\}` ）。
只需找到第最小的 :math:`n` 使得

.. math::

  (1+2+...+n) - x = \frac{n(n+1)}{2} - x

是非负偶数。跳到 :math:`x` 和跳到 :math:`-x` 的次数相同，
因此只考虑 :math:`x` 为正的情况。

  https://www.zhihu.com/question/50790221

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

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


16. 求 :math:`n` 的阶乘末尾有多少个 :math:`0` 。Hint：1个 :math:`5` 和1个 :math:`2` 搭配可以得到1个 :math:`0` ；:math:`2` 的个数比 :math:`5` 多，
因此只关心 :math:`5` 的个数；:math:`25` 包含2个 :math:`5` ，:math:`125` 包含3个 :math:`5` ...。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

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


17. 求一个整数的二进制表示中 :math:`1` 的个数。Hint：移位操作，负数可能造成死循环。 **注：指定移位次数大于或等于对象类型的比特数（如int型的32位），或者对负数进行左移操作，结果都是未定义的** 。
例如：``n >> 32`` 是未定义的，但是允许 ``n >>= 1`` 执行无限次，这是安全的。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

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

    .. code-block:: cpp
      :linenos:

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


    .. code-block:: cpp
      :linenos:

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


18. [LeetCode] Subarray Sum Equals K 子数组和为 :math:`K` 。Hint：依次求数组的前 :math:`n` 项和 :math:`sum[n]` ，:math:`n \in [0, arr\_size]` （注意：0也在内），
将和作为哈希表的key，和的值出现次数作为value；如果存在 :math:`sum[i]−sum[j]=K \ (i \ge j)` ，则 :math:`sum[i]` 和 :math:`sum[j]` 都应该在哈希表中。

  https://leetcode.com/problems/subarray-sum-equals-k/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

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


19. 使用位运算进行加法运算。Hint：原位加法运算等效为 ``^`` 运算，进位等效为 ``&`` 和 ``移位`` 的复合。 **注：C++不允许对负数进行左移运算。**

  https://leetcode.com/problems/sum-of-two-integers/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int getSum(int a, int b)
          {
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


20. [LeetCode] Longest Substring with At Least K Repeating Characters 包含重复字符的最长子串。Hint：由于该字符串只包含小写字母，因此
直接使用长度为26的静态数组来统计字符频率更为简洁高效，不需要使用map。

  https://leetcode.com/problems/longest-substring-with-at-least-k-repeating-characters/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // https://www.cnblogs.com/grandyang/p/5852352.html
      // 使用一个int型（32位）的mask，指示各字符频率是否到达k
      // 以每一个字符作为起点，往后统计。时间复杂度 O(N^2)
      // mask第 idx 位从 0 -> 1，表示对应字符出现了，但是未达到k次
      // mask第 idx 位从 1 -> 0，表示对应字符已经出现了k次
      // mask变成 0，表示这段子串满足要求

      class Solution
      {
      public:
          int longestSubstring(string s, int k)
          {
              int ans = 0;
              int start = 0;
              while(start + k <= s.size())
              {
                  int hash[26] = {0};
                  int mask = 0;
                  int next_start = start + 1;
                  for(int end = start; end < s.size(); ++ end)
                  {
                      int idx = s[end] - 'a';
                      ++ hash[idx];
                      if(hash[idx] < k) mask |= (1 << idx); // 0 -> 1
                      else mask &= ~(1 << idx);             // 1 -> 0
                      if(mask == 0)
                      {
                          ans = max(ans, end - start + 1);
                          next_start = end + 1;
                      }
                  }
                  start = next_start;
              }
              return ans;
          }
      };


21. [LeetCode] 4Sum II 4个数和为0的组合数。Hint：两两之和存入哈希表，时间复杂度和空间复杂度 :math:`\mathcal{O}(N^2)` 。

  https://leetcode.com/problems/4sum-ii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      def fourSumCount(self, A, B, C, D):
          AB = collections.Counter(a+b for a in A for b in B)
          return sum(AB[-c-d] for c in C for d in D)



22. [LeetCode] Maximum Product Subarray 求连续子数组的最大乘积。Hint：数组中存在负数，负负得正，因此相比于连续子数组最大和问题，不仅需要记录以每个元素结尾的连续乘积的最大值，还需要记录最小值。

  https://blog.csdn.net/xblog\_/article/details/72872263




23. 给定一个十进制整数 :math:`N` ，统计从 :math:`1` 到 :math:`N` 所有的整数各位出现的 :math:`1` 的数目。Hint： :math:`1` 的数目 = 个位出现 :math:`1` 的数目 + 十位出现 :math:`1` 的数目 + 百位出现 :math:`1` 的数目  + ......。以百位为例：如果百位数字为0，则百位出现1的次数只由更高位决定，如12013，次数为12 * 100；如果百位数字为1，则百位出现1的次数由更高位和更低位同时决定，如12113，次数为12 * 100 + (113 + 1)；如果百位数字大于1，则百位出现1的次数只由更高位决定，如12213，次数为(12 + 1) * 100。时间复杂度 :math:`\mathcal{O}(\log_{10}(N))` 。

  http://www.cnblogs.com/jy02414216/archive/2011/03/09/1977724.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      typedef unsigned long long ULL;
      ULL number_of_1(ULL N)
      {
        ULL cnt = 0;
        ULL factor = 1;
        ULL lowerNum = 0;
        ULL currNum = 0;
        ULL highNum = 0;
        while(N / factor)
        {
          lowerNum = N - (N / factor) * factor;
          currNum = (N / factor) % 10;
          highNum = N / (factor * 10);
          switch(currNum)
          {
            case 0:
              cnt += highNum * factor;
              break;
            case 1:
              cnt += highNum * factor + (lowerNum + 1);
              break;
            default:
              cnt += (highNum + 1) * factor;
              break;
          }
          factor *= 10;
        }
        return cnt;
      }


24. 数组循环移位：循环右移 :math:`K` 位，时间复杂度 :math:`\mathcal{O}(N)` 。Hint：三次翻转。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      void reverse(int *arr, int begin, int end)
      {
        for(; begin < end; begin++, end--) swap(arr[begin], arr[end]);
      }

      void right_shift(int *arr, int N, int K)
      {
        K %= N;
        reverse(arr, 0, N-K-1);
        reverse(arr, N-K, N-1);
        reverse(arr, 0, N-1);
      }





25. [LeetCode] Divide Two Integers 整数除法。Hint：先取绝对值，做正整数之间的除法；防止溢出。

  https://leetcode.com/problems/divide-two-integers/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int divide(int dividend, int divisor)
          {
              if(dividend == INT_MIN && divisor == -1) return INT_MAX; // 越界则输出最大值
              if(dividend == INT_MIN && divisor == 1) return INT_MIN;
              if(divisor == INT_MIN && dividend == INT_MIN) return 1; // 枚举分子为最小整数时的情形
              if(divisor == INT_MIN) return 0;

              bool sign = (dividend>0) ^ (divisor>0) ? false : true;

              int res = 0;

              bool max_flow = false;
              if(dividend == INT_MIN)
              {
                  dividend = abs(1 + INT_MIN); // 防止取绝对值之后溢出
                  max_flow = true;
              }
              else dividend = abs(dividend);
              divisor = abs(divisor);

              while(dividend >= divisor)
              {
                  int diff = divisor;
                  int n = 1;
                  while(diff <= (dividend >> 1))
                  {
                      diff <<= 1;
                      n <<= 1;
                  }
                  dividend -= diff;
                  res += n;
              }
              if(max_flow && dividend == divisor-1) res += 1;

              return sign? res : -res;
          }
      };


26. [LeetCode] Fraction to Recurring Decimal 循环小数。Hint：小数除法：余数乘以10再求余；如果余数出现重复，则说明是循环小数。

  https://leetcode.com/problems/fraction-to-recurring-decimal/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          string fractionToDecimal(int numerator, int denominator)
          {
              if(numerator == 0 || denominator == 0) return "0";
              int sign_num = numerator > 0? 1:-1;
              int sign_den = denominator > 0? 1:-1;

              long long num = abs((long long)numerator);
              long long den = abs((long long)denominator);

              long long integer = num / den;
              long long rem = num % den;

              string int_part = to_string(integer);
              if(rem) int_part += ".";

              string frac_part = "";
              unordered_map<long long, int> mp;
              int idx = 0;

              while(rem)
              {
                  if(mp.find(rem) != mp.end()) // 余数重复
                  {
                      frac_part.insert(mp[rem], "(");
                      frac_part += ")";
                      break;
                  }
                  mp[rem] = idx ++;
                  frac_part += to_string((10*rem) / den);
                  rem = (10*rem) % den;
              }

              string res = "";
              if(sign_num * sign_den < 0) res += "-";
              res += int_part + frac_part;
              return res;
          }
      };


27. 正整数质因数分解。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      ## 不断除以 2 之后，2 的倍数都不可能再整除 n；3 同理。
      ## 思想类似于：找到 n 以内的素数，即把素数的倍数都排除。
      def decomp(n):
          prime = 2
          while n >= prime:
              if n % prime == 0:
                  print prime
                  n /= prime
              else:
                  prime += 1


28. 旋转数组查找。Hint：采用二分查找的思路。

  - 二分查找

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // preliminary: binary search，时间复杂度 O(logN)
      template<class T>
      int binarySearch(T *arr, int n, const T& target)
      {
        if (arr == nullptr || n <= 0) return -1;
        int low = 0;
        int high = n - 1;
        while (low <= high)
        {
          int mid = low + (high - low) / 2; // mid = (low + high)/2 可能导致溢出
          if (arr[mid] == target) return mid;
          if (arr[mid] < target) low = mid + 1;
          else high = mid - 1;
        }
        return -1;
      }

  - 查找旋转数组最小值（含重复元素）

      https://leetcode.com/problems/find-minimum-in-rotated-sorted-array-ii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一
      // 第一个指针总指向前面递增数组的元素
      // 第二个指针总指向后面递增数组的元素
      // 最终两个指针指向相邻元素：第一个指针指向前面递增数组的最后一个元素，第二个指针指向后面递增数组的第一个元素（也就是最小元素）
      template<class T>
      int findRotateMin(T* arr, int n)
      {
        if (arr == nullptr || n <= 0) return -1;
        int low = 0;
        int high = n - 1;
        while (arr[low] >= arr[high])
        {
          if (high - 1 == low) return high;

          int mid = low + (high - low) / 2;

          // 如果这三个元素相等，则在区间 [low, high] 内顺序查找
          if (arr[low] == arr[mid] && arr[mid] == arr[high]) return (min_element(arr + low, arr + high + 1) - arr);

          if (arr[mid] <= arr[high]) high = mid;
          else low = mid;
        }
        // 如果数组本身是有序的，即 arr[0] < arr[n-1]，则第一个元素就是最小值
        return 0;
      }


    .. code-block:: cpp
      :linenos:

      // 方法二
      // 如果 arr[mid] < arr[mid-1]，则 arr[mid] 是最小值
      // 每次比较 nums[mid] 与 nums[high]，如果两者相等，则 --high
      template<class T>
      int findRotateMin(T* arr, int n)
      {
        if (arr == nullptr || n <= 0) return -1;
        int low = 0;
        int high = n - 1;
        while (low <= high)
        {
          int mid = low + (high - low) / 2;
          if (mid > 0 && arr[mid] < arr[mid-1]) return mid;

          if (arr[mid] == arr[high]) --high;

          else if (arr[mid] < arr[high]) high = mid - 1;

          else low = mid + 1;
        }
        return 0;
      }

  - 在旋转数组查找目标值（无重复元素）

      https://leetcode.com/problems/search-in-rotated-sorted-array/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 每次比较 nums[mid] 与 nums[high]
      class Solution
      {
      public:
          int search(vector<int>& nums, int target)
          {
              int n = nums.size();
              if(n == 0) return -1;
              int low = 0;
              int high = n - 1;
              while(low <= high)
              {
                  int mid = low + (high - low) / 2;
                  if(nums[mid] == target) return mid;

                  if(nums[mid] < nums[high]) // 注：只有当 low == high，才会出现： mid == high，nums[mid] == nums[high]
                  {
                      if(nums[mid] < target && target <= nums[high]) low = mid + 1;
                      else high = mid - 1;
                  }
                  else
                  {
                      if(nums[mid] > target && target >= nums[low]) high = mid - 1;
                      else low = mid + 1;
                  }
              }
              return -1;
          }
      };

  - 在旋转数组查找目标值（含重复元素）

      https://leetcode.com/problems/search-in-rotated-sorted-array-ii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // https://www.cnblogs.com/grandyang/p/4325840.html
      // 相对于上例，需要增加一个判断：如果 nums[mid] 与 nums[high] 相等，则 --high
      class Solution
      {
      public:
          bool search(vector<int>& nums, int target)
          {
              int n = nums.size();
              if(n == 0) return false;
              int low = 0;
              int high = n - 1;
              while(low <= high)
              {
                  int mid = low + (high - low) / 2;
                  if(nums[mid] == target) return true;

                  if(nums[mid] == nums[high]) -- high; // 增加这个判断。注：只有当 low == high，才会出现： mid == high 。

                  else if(nums[mid] < nums[high])
                  {
                      if(nums[mid] < target && target <= nums[high]) low = mid + 1;
                      else high = mid - 1;
                  }
                  else
                  {
                      if(nums[mid] > target && target >= nums[low]) high = mid - 1;
                      else low = mid + 1;
                  }
              }
              return false;
          }
      };


29. [LeetCode] Maximum Gap 最大间隔。Hint：方法一，普通排序，逐个比较；方法二，桶排序。将 :math:`n` 个数放到 :math:`n+1` 个桶中，最小值放第一个桶，
最大值放最后一个桶，每个桶的大小为 :math:`\frac{max-min}{n}` 。根据鸽巢原理，至少存在一个桶为空。最大间隔必然出现在空桶两侧，且只与左侧桶的最大值、
右侧桶的最小值有关。（事实上，可以将 :math:`n` 个数放到 :math:`n` 个桶中，如果没有空桶，则刚好每个桶有且仅有一个数，最大间隔出现在相邻桶中；如果某个桶有2个数以上，
说明存在有空桶，最大间隔出现在非空的相邻桶中。总之，最大间隔不会出现在一个桶中。）

  https://leetcode.com/problems/maximum-gap/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 建立 n 个桶
      class Solution
      {
      public:
          int maximumGap(vector<int>& nums)
          {
              size_t n = nums.size();
              if(n < 2) return 0;

              int MIN = *min_element(nums.begin(), nums.end());
              int MAX = *max_element(nums.begin(), nums.end());
              if(MIN == MAX) return 0;

              vector<vector<int>> bucket(n, vector<int>{});

              double delta = (MAX - MIN) / double(n - 1);
              for(size_t k = 0; k < n; ++k)
              {
                  int idx = (nums[k] - MIN) / delta;
                  bucket[idx].push_back(nums[k]);
              }

              int gap = 0;
              size_t pre = 0;
              size_t curr = 1;
              while(curr < bucket.size())
              {
                  if(bucket[curr].size() == 0) curr ++;
                  else
                  {
                      if(curr - pre >= 1)
                      {
                          int pre_max = *max_element(bucket[pre].begin(), bucket[pre].end());
                          int curr_min = *min_element(bucket[curr].begin(), bucket[curr].end());
                          gap = max(gap, curr_min - pre_max);
                      }
                      pre = curr;
                      curr ++;
                  }
              }
              return gap;
          }
      };



30. 数组操作模拟大数乘法。Hint：从低位到高位，采用竖式计算，记录所有位的乘积，再将对应位的结果相加，最后进位。假设数组 :math:`a` 和 :math:`b` 从低位到高位存储了两个大数（可能存在小数点），则乘积为 :math:`ans[i+j] = ans[i+j] + a[i] + b[j]` 。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      def preProcess(a):
          ## input: str
          ## output: list, l
          pf = a.find('.')
          lf = 0
          if pf != -1:
              lf = len(a) - 1 - pf ## 小数位数
              a = a[:pf] + a[pf+1:] ## 去掉小数点
          a = list(a)
          a = a[::-1] ## 翻转数组，a[0] 表示最低位
          return a, lf

      def strMul(a, b):
          a, la = preProcess(a)
          b, lb = preProcess(b)
          lf = la + lb

          ans = [0 for _ in range(len(a) + len(b))]
          for ia in range(len(a)):
              for ib in range(len(b)):
                  ans[ia+ib] += int(a[ia]) * int(b[ib])
          carry = 0
          for i in range(len(ans)):
              tmp = ans[i] + carry
              ans[i] = tmp % 10
              carry = tmp / 10
          ans = ans[::-1] ## 翻转数组

          if lf > 0:
              ans.insert(len(ans) - lf, '.') ## 插入小数点
          if ans[0] == 0:
              ans = ans[1:] ## 最高位是 0 则去掉
          iz = len(ans)-1
          while lf > 0 and ans[iz] == 0: ## 去掉小数点末尾的 0
              iz -= 1

          s = ''
          for e in ans[:iz+1]:
              s += str(e)

          return s


31. [LeetCode] Number of Islands 孤岛个数。Hint：使用队列，广度优先遍历（BFS）。

  https://leetcode.com/problems/number-of-islands/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
         void traverseIsland(vector<vector<char>>& grid, int m, int n, const int M, const int N)
          {
              queue<pair<int, int>> que;

              que.push(make_pair(m, n));
              grid[m][n] = '0';

              while (!que.empty())
              {
                  pair<int, int> p = que.front();
                  que.pop();

                  if (p.first - 1 >= 0 && grid[p.first - 1][p.second] == '1')
                  {
                      grid[p.first - 1][p.second] = '0';
                      que.push(make_pair(p.first - 1, p.second));
                  }
                  if (p.first + 1 < M && grid[p.first + 1][p.second] == '1')
                  {
                      grid[p.first + 1][p.second] = '0';
                      que.push(make_pair(p.first + 1, p.second));
                  }
                  if (p.second - 1 >= 0 && grid[p.first][p.second - 1] == '1')
                  {
                      grid[p.first][p.second - 1] = '0';
                      que.push(make_pair(p.first, p.second - 1));
                  }
                  if (p.second + 1 < N && grid[p.first][p.second + 1] == '1')
                  {
                      grid[p.first][p.second + 1] = '0';
                      que.push(make_pair(p.first, p.second + 1));
                  }
              }
          }

          int numIslands(vector<vector<char>>& grid)
          {
              if(grid.size()==0) return 0;
              int M = grid.size();
              int N = grid[0].size();
              int island = 0;
              for(int m = 0; m < M; ++m)
              {
                  for(int n = 0; n < N; ++n)
                  {
                      if(grid[m][n]=='1')
                      {
                          island += 1;
                          traverseIsland(grid, m, n, M, N);
                      }
                  }
              }
              return island;
          }
      };


32. 回文。

  - [LeetCode] Longest Palindromic Substring 最长回文子串（子串连续）。Hint：中心扩展法，回文中心的两侧互为镜像，将每一个位置作为中心进行扩展，回文分偶数和奇数；动态规划，类似于矩阵连乘问题，逐渐增大步长。

      https://leetcode.com/problems/longest-palindromic-substring/

    .. math::
       :nowrap:

       $$
       dp[i][i] = true
       $$

       $$
       dp[i][j] =
       \begin{cases}
       true & &\ s[i] = s[j]\ \&\&\ (i \leqslant j \leqslant i+1\ ||\ dp[i+1][j-1]) \\
       false & &\ else
       \end{cases}
       $$


  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
        :linenos:

        // 方法一，中心扩展法
        class Solution {
        public:
            void Palindrome(int i, int j, string s, int& start, int& longest)
            {
                while(i >= 0 && j < s.size() && s.at(i) == s.at(j))
                {
                    i--;
                    j++;
                }
                i += 1;
                j -= 1;
                if(j-i+1 > longest)
                {
                    longest = j-i+1;
                    start = i;
                }
            }
            string longestPalindrome(string s) {
                int len = s.size();
                if(len <= 1) return s;
                int start = 0;
                int longest = 1;
                for(int i = 0; i < len-1; ++ i)
                {
                    Palindrome(i, i, s, start, longest);
                    Palindrome(i, i+1, s, start, longest);
                }
                string str;
                str.assign(s, start, longest);
                return str;
            }
        };

    .. code-block:: cpp
       :linenos:

       // 方法二，动态规划
       class Solution
       {
       public:
           string longestPalindrome(string s)
           {
               if(s.size() <= 1) return s;
               size_t len = s.size();
               vector<vector<bool>> dp(len, vector<bool>(len, false));
               size_t start = 0;
               size_t longest = 1;
               for(size_t i = 0; i < len; ++i) dp[i][i] = true;
               for(size_t gap = 0; gap < len; ++ gap)
               {
                   for(int i = 0; i + gap < len; ++ i)
                   {
                       int j = i + gap;
                       if(s[i] == s[j])
                       {
                           if(j - i <= 1 || dp[i+1][j-1])
                           {
                               dp[i][j] = true;
                               longest = j - i + 1; // 由于步长是逐渐增大的，因此最后得到的回文子串一定是最长的
                               start = i;
                           }
                           else dp[i][j] = false;
                       }
                   }
               }
               vector<vector<bool>>().swap(dp);
               return s.substr(start, longest);
           }
       };

  - [LeetCode] Longest Palindromic Subsequence 最长回文子序列（子序列可以不连续）。Hint：寻找原字符串与翻转字符串的最长公共子序列，动态规划。

      https://leetcode.com/problems/longest-palindromic-subsequence/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          // 寻找字符串 str 与其翻转字符串的最长公共子序列
          int lcsLength(string& str)
          {
              int len = str.size();
              vector<vector<int>> dp(len+1, vector<int>(len+1, 0));
              for(int i = 1; i <= len; ++i)
              {
                  for(int j = len - 1; j >= 0; --j) // 注意这里 j 是反向的
                  {
                      if(str[i-1] == str[j]) dp[i][j] = dp[i-1][j+1] + 1;
                      else dp[i][j] = max(dp[i-1][j], dp[i][j+1]);
                  }
              }
              int ans = dp[len][0];
              vector<vector<int>>().swap(dp);
              return ans;
          }

          int longestPalindromeSubseq(string s)
          {
              if(s.size() <= 1) return s.size();
              return lcsLength(s);
          }
      };


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

  - RCNN（三）：Fast R-CNN

      https://blog.csdn.net/u011587569/article/details/52151871

  - 【RCNN系列】【超详细解析】

      https://blog.csdn.net/amor_tila/article/details/78809791

  - 实例分割模型Mask R-CNN详解：从R-CNN，Fast R-CNN，Faster R-CNN再到Mask R-CNN

      https://blog.csdn.net/jiongnima/article/details/79094159

  - (Mask RCNN)——论文详解(真的很详细)

      https://blog.csdn.net/wangdongwei0/article/details/83110305

  - ROI-Align 原理理解

      https://blog.csdn.net/gusui7202/article/details/84799535


4. Focal Loss（样本不均衡：正/负样本数量不均衡（ :math:`\alpha` ），简单/困难样本数量不均衡（ :math:`\gamma` ））

  .. math::

      CE & = &\ -y \log y_t - (1 - y) \log (1 - y_t) & &\ [\text{Cross Entropy Loss}] \\
      FL & = &\ -y \alpha (1 - y_t)^\gamma \log y_t - (1 - y) (1 - \alpha) y_t^\gamma \log (1 - y_t) & &\ [\text{Focal Loss}]

  即

  .. math::
      :nowrap:

      $$
      CE =
      \begin{cases}
      - \log y_t, & &\ y=1\\
      - \log (1 - y_t), & &\ y=0
      \end{cases}
      $$

      $$
      FL =
      \begin{cases}
      - \alpha (1 - y_t)^\gamma \log y_t, & &\ y=1\\
      - (1 - \alpha) y_t^\gamma \log (1 - y_t), & &\ y=0
      \end{cases}
      $$


  - 损失函数改进方法之Focal Loss

      https://blog.csdn.net/sinat_24143931/article/details/79033538

  - RetinaNet论文理解

      https://blog.csdn.net/wwwhp/article/details/83317738

  - Focal Loss理解

      https://www.cnblogs.com/king-lps/p/9497836.html


5. FCN（Fully Convolutional Networks）

  - FCN学习:Semantic Segmentation

      https://zhuanlan.zhihu.com/p/22976342?utm_source=tuicool&utm_medium=referral

  - FCN于反卷积(Deconvolution)、上采样(UpSampling)

      https://blog.csdn.net/nijiayan123/article/details/79416764

6. FPN（Feature Pyramid Networks for Object Detection）

  https://www.cnblogs.com/fangpengchengbupter/p/7681683.html

7. CapsuleNet解读

  https://blog.csdn.net/u013010889/article/details/78722140/


8. 轻量级网络--MobileNet论文解读

  https://blog.csdn.net/u011974639/article/details/79199306


其他
--------------

1. 理解数据库的事务，ACID，CAP和一致性

  https://www.jianshu.com/p/2c30d1fe5c4e
