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

1. 找出数组中的特异数字（Single Number）

  - 1 个数字出现奇数次，其余数字出现偶数次。Hint：异或运算。

  - 2 个数字出现奇数次，其余数字出现偶数次。Hint：先做异或运算，得到的是这两个数的异或结果；找到该结果的二进制表示中为 1 的某一位，根据该位为 0/1 将数组分为两组，分别做异或运算。

      https://www.jianshu.com/p/e1331664c8cf

  - 1 个数字出现 :math:`1` 次，其余数字出现 :math:`k` 次。Hint：利用大小为 32 的数组，统计二进制各位出现 1 的次数，对 :math:`k` 取模；最终 32 位数组的值就是 Single Number 的二进制表示。

      https://cloud.tencent.com/developer/article/1131946

  - 一般情形：1 个数字出现 :math:`p` 次，其余数字出现 :math:`k` 次。

      https://blog.csdn.net/wlwh90/article/details/89712795

      https://cloud.tencent.com/developer/article/1131945

      https://leetcode.com/problems/single-number-ii/discuss/43295/Detailed-explanation-and-generalization-of-the-bitwise-operation-method-for-single-numbers


2. 均匀分布生成其他分布的方法。Hint：中心极限定理。

  https://blog.csdn.net/haolexiao/article/details/60511164

3. 海量数据处理。Hint：哈希方法，把大文件划分成小文件，读进内存依次处理，如果需要统计频率/个数，再利用哈希；Bitmap，用一个（或几个）比特位来标记某个元素对应的值。

  - 面试题集锦

      https://blog.csdn.net/v_july_v/article/details/6685962

  - 大文件中返回频数最高的100个词

      https://blog.csdn.net/tiankong\_/article/details/77240283

4. 链表（注：对每一个节点操作之前，应先考虑该节点是否为空）

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
          newHead -> next = NULL;
          ListNode* post;
          while(curr)
          {
              post = curr -> next;
              curr -> next = newHead;
              newHead = curr;
              curr = post;
          }
          return newHead;
      }

    .. code-block:: cpp
      :linenos:

      // 方法二，递归
      ListNode* reverseList(ListNode* head)
      {
          if(head==NULL || head->next==NULL) return head;
          else
          {
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



  - 求有环单链表中的环长、环起点、链表长。Hint：快慢指针。

      https://www.cnblogs.com/xudong-bupt/p/3667729.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 判断链表是否有环

      class Solution
      {
      public:
          bool hasCycle(ListNode *head)
          {
              if(!head || !head->next) return false;
              ListNode* slow = head;
              ListNode* fast = head;
              while(fast && fast -> next)
              {
                  slow = slow -> next;
                  fast = fast -> next -> next;
                  if(slow == fast) return true;
              }
              return false;
          }
      };

  - 判断两个链表是否相交并找出交点。Hint：方法一，先求两个链表的长度差，双指针法；方法二，分别用栈保存两个链表的节点的地址（指针），从后往前比较。如果只需要判断两个链表是否相交，只需判断两个链表最后一个节点是否相同。

      https://blog.csdn.net/jiary5201314/article/details/50990349

  - 单链表 :math:`\mathcal{O}(1)` 时间删除给定节点。Hint：交换当前节点与下一个节点的值，删除下一个节点。

      https://blog.csdn.net/qq_35546040/article/details/80341136

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      bool removeNode(ListNode* pNode)
      {
          if(pNode == NULL) return true;
          if(pNode -> next == NULL) return false;
          pNode -> val = pNode -> next -> val;
          pNode -> next = pNode -> next -> next;
          return true;
      }
      // 注：如果需要删除最后一个节点，直接令 pNode -> next = NULL 是无法改变实参的（传值调用）
      // 必须从链表头节点开始遍历，找到该节点的前驱节点
      // 还要考虑该链表只有一个节点的情形
      // 另外，该函数内不要 delete 该指针，同样是因为 pNode 不是引用形参

  - 输出该链表中倒数第 :math:`k` 个结点。Hint：双指针法，第一个指针先走 :math:`k-1` 步，然后第二个指针从头节点开始，与第一个指针同步往后移；当第一个指针移到最后一个节点，第二个指针即指向倒数第 :math:`k` 个结点。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      ListNode* FindKthToTail(ListNode* pListHead, unsigned int k)
      {
          if(!pListHead || k == 0) return NULL;

          unsigned int tk = 1;
          ListNode* p = pListHead;
          while(tk < k)
          {
              p = p -> next;
              if(!p) return NULL;
              tk += 1;
          }

          ListNode* pk = pListHead;
          while(p -> next)
          {
              p = p -> next;
              pk = pk -> next;
          }
          return pk;
      }


  - 链表排序。Hint：方法一，快速排序或归并排序；方法二，遍历链表把值存入数组，使用数组的排序方法，再把值赋回链表。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // https://leetcode.com/problems/sort-list/

      class Solution
      {
      public:
          ListNode* sortList(ListNode* head)
          {
              quickSort(head, NULL);
              return head;
          }
      private:
          // 由于链表无法反向遍历，需要重新考虑如何交换两个位置的数值
          // pre 指向 curr 的前一个数，或者指向第一个比 key 大的数的前一个数
          // 当 curr 指向的数比 key 小，pre 移到下一位，交换两者的值
          ListNode* partion(ListNode* head, ListNode* tail)
          {
              int key = head -> val;
              ListNode* pre = head;
              ListNode* curr = head -> next;
              while(curr != tail)
              {
                  if(curr -> val < key)
                  {
                      pre = pre -> next;
                      swap(pre -> val, curr -> val);
                  }
                  curr = curr -> next;
              }
              swap(head -> val, pre -> val);
              return pre;
          }
          void quickSort(ListNode* head, ListNode* tail)
          {
              if(head == tail || (head -> next) == tail) return;
              ListNode* mid = partion(head, tail);
              quickSort(head, mid);
              quickSort(mid->next, tail);
          }
      };

  - 将二叉搜索树转换为升序排序的双向链表。Hint：中序遍历。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      struct TreeNode
      {
          int val;
          struct TreeNode *left;
          struct TreeNode *right;
          TreeNode(int x) : val(x), left(NULL), right(NULL) {}
      };

      class Solution
      {
      public:
          TreeNode* Convert(TreeNode* pRootOfTree)
          {
              pRootOfTree = converTree2List(pRootOfTree);
              return pRootOfTree;
          }
      private:
          // 返回的是转换之后的链表的头节点
          TreeNode* converTree2List(TreeNode* root)
          {
              if(!root) return NULL;

              TreeNode* l = converTree2List(root -> left);
              while(l && l -> right) l = l -> right; // 根节点应该接在左子树链表的尾节点之后
              if(l) l -> right = root;
              root -> left = l;

              TreeNode* r = converTree2List(root -> right);
              if(r) r -> left = root;
              root -> right = r; // 根节点应该接在右子树链表的头节点之前

              while(root -> left) root = root -> left; // 找到头节点
              return root;
          }
      };

  - 删除链表中的重复节点。Hint：可能会删除头节点；注意尾节点处是否有重复元素。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          ListNode* deleteDuplication(ListNode* pHead)
          {
              if(!pHead || !(pHead -> next)) return pHead;

              ListNode* newHead = new ListNode(0); // 临时申请一个新的节点，以处理头节点被删除的情形
              newHead -> next = pHead;
              ListNode* th = newHead;

              ListNode* curr = pHead;
              ListNode* post = curr -> next;
              while(true)
              {
                  if(post && curr -> val != post -> val)
                  {
                      th -> next = curr;
                      th = curr; // curr是不重复的节点
                      curr = post;
                      post = post -> next;
                      if(!post) break; // 尾节点处不是重复元素
                  }
                  else
                  {
                      while(post && curr -> val == post -> val) post = post -> next;
                      curr = post;

                      if(!post) // 尾节点处是重复元素
                      {
                          th -> next = NULL;
                          break;
                      }
                      else post = post -> next;

                      if(!post) // 尾节点处不是重复元素
                      {
                          th -> next = curr;
                          break;
                      }
                  }
              }
              th = newHead -> next;
              delete newHead; // 删除临时节点
              return th; // 返回的是临时节点指向的下一个节点
          }
      };


  - 重组链表，首尾交错，L0→L1→…→Ln-1→Ln 转换为 L0→Ln→L1→Ln-1→L2→Ln-2→…。Hint：首先，链表中间截断；然后，第二段链表翻转；最后，合并两个子链表。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          void reorderList(ListNode* head)
          {
              if(!head || !head -> next || !head -> next -> next) return;

              // 第一步：找到中间节点
              ListNode* slow = head;
              ListNode* fast = head;
              while(fast && fast -> next)
              {
                  slow = slow -> next;
                  fast = fast -> next -> next;
              }

              // 第二步：翻转第二段链表
              ListNode* secondHead = slow -> next;
              slow -> next = NULL; // 第一段链表的尾节点
              ListNode* p = secondHead -> next;
              secondHead -> next = NULL; // 第二段链表的尾节点
              ListNode* q;
              while(p)
              {
                  q = p -> next;
                  p -> next = secondHead;
                  secondHead = p;
                  p = q;
              }

              // 第三步：交叉合并两个子链表
              ListNode* h1 = head;
              ListNode* h2 = secondHead;
              while(h1 && h2)
              {
                  ListNode* h1Post = h1 -> next;
                  ListNode* h2Post = h2 -> next;
                  h1 -> next = h2;
                  h2 -> next = h1Post;
                  h1 = h1Post;
                  h2 = h2Post;
              }
          }
      };

  - [LeetCode] Partition List 分割链表，小于 :math:`x` 的排前面，不小于 :math:`x` 的排后面。Hint：先遍历链表，用一个数组保存小于 :math:`x` 的值，另一个数组保存不小于 :math:`x` 的值。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          ListNode* partition(ListNode* head, int x)
          {
              if(!head || !head->next) return head;
              vector<int> small;
              vector<int> big;
              ListNode* p = head;
              while(p)
              {
                  if(p -> val < x) small.push_back(p -> val);
                  else big.push_back(p -> val);
                  p = p -> next;
              }
              p = head;
              int k = 0;
              while(k < small.size())
              {
                  p -> val = small[k];
                  p = p -> next;
                  ++k;
              }
              k = 0;
              while(k < big.size())
              {
                  p -> val = big[k];
                  p = p -> next;
                  ++k;
              }
              vector<int>().swap(small);
              vector<int>().swap(big);
              return head;
          }
      };

5. 排列组合：:math:`k` 个球放入 :math:`m` 个盒子

  https://blog.csdn.net/qwb492859377/article/details/50654627?tdsourcetag=s_pctim_aiomsg


6. [LeetCode] Sort Colors（三颜色排序 → K 颜色排序）

  https://blog.csdn.net/princexiexiaofeng/article/details/79645511

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          void sortColors(vector<int>& nums)
          {
              if(nums.size() <= 1) return;
              int left = 0;
              int right = nums.size() - 1;
              for(int mid = left; mid <= right; ++ mid)
              {
                  while(nums[mid]==2 && mid < right)
                  {
                      swap(nums[mid], nums[right]);
                      right --;
                  }
                  while(nums[mid]==0 && mid > left)
                  {
                      swap(nums[mid], nums[left]);
                      left ++;
                  }
              }
          }
      };

      // 注：要先判断 nums[mid]==2，再判断 nums[mid]==0，否则会出错，如 [1,2,0]
      // 因为 2 是往后交换，0 是往前交换；2 交换得到的可能是 0，但可以保证 0 交换得到的不会是 2，因为 2 在 0 之前被处理了
      // 如果判断顺序反过来，2 交换得到的 0 不会被处理

7. 找到数组第 :math:`k` 大的数

  https://leetcode.com/problems/kth-largest-element-in-an-array/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:
      :emphasize-lines: 7,8,15,16,24,25,26,29,30

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

          // T(n) = T(n/2) + O(n)，时间复杂度 O(n)
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

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int maxProfit(vector<int>& prices)
          {
              if(prices.size() <= 1) return 0;
              int profit = 0;
              int minimal = INT_MAX;
              for(int p: prices)
              {
                  profit = max(profit, p - minimal);
                  minimal = min(p, minimal);
              }
              return profit;
          }
      };

  - 无限次交易

      http://www.cnblogs.com/grandyang/p/4280803.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int maxProfit(vector<int>& prices)
          {
              if(prices.size() <= 1) return 0;
              int profit = 0;
              for(int i = 0; i < prices.size() - 1; ++i) profit += max(prices[i+1] - prices[i], 0);
              return profit;
          }
      };

  - 最多两次交易

      http://www.cnblogs.com/grandyang/p/4281975.html

  - 最多k次交易

      http://www.cnblogs.com/grandyang/p/4295761.html

      https://blog.csdn.net/linhuanmars/article/details/23236995

  - 交易冷却

      https://www.cnblogs.com/grandyang/p/4997417.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // buy[i] = max(buy[i-1], cool[i-1] - prices[i])
      // sell[i] = max(sell[i-1], buy[i-1] + prices[i])
      // cool[i] = sell[i-1] => buy[i] = max(buy[i-1], sell[i-2] - prices[i])

      class Solution
      {
      public:
          int maxProfit(vector<int>& prices)
          {
              if(prices.size() <= 1) return 0;
              int pre_sell = 0;
              int sell = 0;
              int pre_buy = INT_MIN;
              int buy = 0;
              for(int p : prices)
              {
                  buy = max(pre_buy, pre_sell - p); // 这里的 pre_sell 其实是 pre_pre_sell
                  pre_sell = sell; // pre_sell 更新晚一步
                  sell = max(pre_sell, pre_buy + p);
                  pre_buy = buy;
              }
              return sell;
          }
      };

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


11. 寻找重复数。数值范围为 :math:`\{ 1,2,3,...,n \}` ，有的出现 2 次，有的出现 1 次。Hint：把数组元素的值当做下标，由于元素存在重复，因此必然会 **重复多次访问同一个位置** 。
从另一个角度讲，访问序列中存在“环”。排序的时间复杂度高，哈希不满足空间复杂度为 :math:`\mathcal{O}(1)` 的要求。

  - [LeetCode] Find the Duplicate Number 找到一个重复数字（共有 :math:`n+1` 个数）。

      https://leetcode.com/problems/find-the-duplicate-number/

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
                  slow = nums[slow]; // 注意，这里下标没有减 1
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
              int duplicate = -1;
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
                  if(duplicate != -1) break;
              }
              return duplicate;
          }
      };


  - [LeetCode] Find All Duplicates in an Array 找到所有重复数字（共有 :math:`n` 个数）。

      https://leetcode.com/problems/find-all-duplicates-in-an-array/

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


13. [LeetCode] Longest Consecutive Sequence 最长连续序列。Hint：方法一，排序；方法二，对于每个元素 :math:`n` ，搜索 :math:`n+1` 是否在数组中，使用 hash/set 可以获得 :math:`\mathcal{O}(1)` 的查找复杂度。

  https://leetcode.com/problems/longest-consecutive-sequence/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
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


14. 最大公约数与最小公倍数。Hint：辗转相除法；最小公倍数等于两数乘积除以最大公约数。

  https://www.cnblogs.com/Arvin-JIN/p/7247619.html

15. 跳跃的蚂蚱：从 0 点出发，往正或负向跳跃，第一次跳跃一个单位，之后每次跳跃距离比上一次多一个单位，跳跃多少次可到到达坐标 :math:`x` 处？
Hint：走 :math:`n` 步之后能到达的坐标是一个差为 2 的等差数列（如 :math:`n=2` ，可到达 :math:`\{-3,-1,1,3\}` ）。
只需找到最小的 :math:`n` 使得

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


17. 求一个整数的二进制表示中 :math:`1` 的个数。Hint：移位操作；负数可能造成死循环。 **注：C++中，指定移位次数大于或等于对象类型的比特数（如int型的32位），或者对负数进行左移操作，结果都是未定义的** 。
例如：``n >> 32`` 是未定义的，但是允许 ``n >>= 1`` 执行无限次，这是安全的。延伸：检查一个数是否是 2 的整次幂，Hint：二进制表示只有一个 1；检查一个数是否是 4 的整次幂，Hint：4 的整次幂的二进制表示中，
1 都在奇数位；检查一个数是否是 3 的整次幂，Hint：质数的整次幂的质因子只有该质数本身。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一：不断右移 n。如果 n 是负数，需要保持最高位为 1，不断移位后这个数字会变成 0xFFFFFFFF 而陷入死循环。
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

      // 方法二：n 不动，左移一个比较子。
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

      // 方法三：把一个整数减 1，再和原整数做逻辑与运算，会把该整数最右边的一个 1 变成 0。
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

    .. code-block:: cpp
      :linenos:

      // 检查一个数是否是 2 的整次幂
      bool checkPower2(int n)
      {
        return n > 0 && (n & (n - 1)) == 0;
      }

    .. code-block:: cpp
      :linenos:

      // 检查一个数是否是 4 的整次幂
      bool checkPower4(int n)
      {
        if(n > 0 && (n & (n - 1)) == 0) // 先确保是 2 的整次幂（只有一个 1）
        {
          if((n & 0x55555555) == n) return true; // 0x55555555 = 0101 0101 0101 0101 0101 0101 0101 0101
        }
        return false;
      }

    .. code-block:: cpp
      :linenos:

      // 检查一个数是否是 3 的整次幂
      bool checkPower3(int n)
      {
        return n > 0 && 1162261467 % n == 0; // 3^19 = 1162261467 是 int 型中最大的 3 的整次幂
      }

18. [LeetCode] Subarray Sum Equals K 子数组和为 :math:`K` 。Hint：依次求数组的前 :math:`n` 项和 :math:`sum[n]` ，:math:`n \in [0, arr\_size]` （注意：0也在内），
将和作为哈希表的key，和的值出现次数作为value；如果存在 :math:`sum[i]−sum[j]=K \ (i \ge j)` ，则 :math:`sum[i]` 和 :math:`sum[j]` 都应该在哈希表中。

  https://leetcode.com/problems/subarray-sum-equals-k/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      ## https://leetcode.com/problems/subarray-sum-equals-k/solution/ : Approach #4 Using hashmap

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
              sum_to_num[0] = 1 ## 前 0 项和

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




23. 给定一个十进制整数 :math:`N` ，统计从 :math:`1` 到 :math:`N` 所有的整数各位出现的 :math:`1` 的数目。Hint： :math:`1` 的数目 = 个位出现 :math:`1` 的数目 + 十位出现 :math:`1` 的数目 + 百位出现 :math:`1` 的数目  + ......。以百位为例：如果百位数字为0，则百位出现1的次数只由更高位决定，如12013，次数为12 * 100；如果百位数字为1，则百位出现1的次数由更高位和更低位同时决定，如12113，次数为12 * 100 + (13 + 1)；如果百位数字大于1，则百位出现1的次数只由更高位决定，如12213，次数为(12 + 1) * 100。时间复杂度 :math:`\mathcal{O}(\log_{10}(N))` 。

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
        ULL higherNum = 0;
        while(N / factor)
        {
          lowerNum = N - (N / factor) * factor;
          currNum = (N / factor) % 10;
          higherNum = N / (factor * 10);
          switch(currNum)
          {
            case 0:
              cnt += higherNum * factor;
              break;
            case 1:
              cnt += higherNum * factor + (lowerNum + 1);
              break;
            default:
              cnt += (higherNum + 1) * factor;
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
              if(dividend == INT_MIN && divisor == INT_MIN) return 1; // 枚举分子为最小整数时的情形
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

      ## 不断除以 2 之后，2 的倍数都不可能再整除 n；3,5,7,... 同理。
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
        int high = n - 1; // 查找区间： [0, n)
        while (low <= high)
        {
          int mid = low + (high - low) / 2; // mid = (low + high)/2 可能导致溢出
          if (arr[mid] == target) return mid;
          if (arr[mid] < target) low = mid + 1;
          else high = mid - 1;
        }
        return -1;
      }

    .. code-block:: cpp
      :linenos:

      // 浮点数二分，不存在区间取整，要求达到某个精度

      // 例：在区间 [low, high] 二分查找开方数

      #define eps 1e-5

      bool judge(double mid, double x)
      {
        return mid >= x / mid;
      }

      double search(double low, double high, double x)
      {
        while (high - low > eps)
        {
          double mid = low + (high - low) / 2;
          if (judge(mid, x)) high = mid;
          else low = mid;
        }
        return low + (high - low) / 2; // 此时 low 和 high 比较接近，取它们的均值作为最终结果
      }

    .. code-block:: python
      :linenos:

      ## 返回区间 [first, last) 内第一个不小于 target 的位置
      ## 如果所有数都小于 target，则返回 last
      def lower_bound(a, first, last, target):
          if first > last:
              return None
          while first < last: ## [first, last)不为空
              mid = first + (last - first) // 2
              if a[mid] < target:
                  first = mid + 1
              else:
                  last = mid
          return first  ## 返回 last 也行，因为 [first, last) 为空的时候它们相等

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

              vector<vector<int>> bucket(n, vector<int>(2, 0)); // 大小为 n * 2
              for(size_t k = 0; k < n; ++k)
              {
                  bucket[k][0] = INT_MAX;
                  bucket[k][1] = INT_MIN;
              }


              double delta = (MAX - MIN) / double(n - 1);
              for(size_t k = 0; k < n; ++k)
              {
                  int idx = (nums[k] - MIN) / delta;
                  bucket[idx][0] = min(nums[k], bucket[idx][0]);
                  bucket[idx][1] = max(nums[k], bucket[idx][1]);
              }

              int gap = 0;
              size_t pre = 0;
              size_t curr = 1;
              while(curr < bucket.size())
              {
                  if(bucket[curr][0] == INT_MAX && bucket[curr][1] == INT_MIN) curr ++; // 空桶
                  else
                  {
                      if(curr - pre >= 1)
                      {
                          int pre_max = bucket[pre][1];
                          int curr_min = bucket[curr][0];
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


31. [LeetCode] Number of Islands 孤岛个数。Hint：使用队列，广度优先遍历（BFS）。延伸：从坐标 :math:`(0, 0)` 到 :math:`(n-1, m-1)` 的最短时间，只能走四邻域，:math:`map[i][j] = 1` 表示有障碍。Hint：BFS，第一个到达的就是时间最短的。

  https://leetcode.com/problems/number-of-islands/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 孤岛个数
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
                      grid[p.first - 1][p.second] = '0'; // 入队需要改变标志位，避免后续过程中同一坐标重复入队
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

    .. code-block:: cpp
      :linenos:

      // 最短时间
      // https://www.nowcoder.com/practice/365493766c514d0da0cd774d3d40fd49?tpId=8&tqId=11040&tPage=1&rp=1&ru=/ta/cracking-the-coding-interview&qru=/ta/cracking-the-coding-interview/question-ranking

      struct point
      {
          int x;
          int y;
          int time;
          point(int _x, int _y, int _time): x(_x), y(_y), time(_time){}
      };

      class Flood
      {
      public:
          int floodFill(vector<vector<int> > map, int n, int m)
          {
              queue<point> q;
              if(map[0][0] != 1)
              {
                  q.push(point(0, 0, 0));
                  map[0][0] = 1;
              }
              while(!q.empty())
              {
                  auto p = q.front();
                  q.pop();
                  if(p.x == n-1 && p.y == m-1) return p.time;
                  if(p.y >= 1 && map[p.x][p.y-1] != 1)
                  {
                      q.push(point(p.x, p.y-1, p.time+1));
                      map[p.x][p.y-1] = 1; // 入队需要改变标志位，避免后续过程中同一坐标重复入队
                  }
                  if(p.x >= 1 && map[p.x-1][p.y] != 1)
                  {
                      q.push(point(p.x-1, p.y, p.time+1));
                      map[p.x-1][p.y] = 1;
                  }
                  if(p.x < n-1 && map[p.x+1][p.y] != 1)
                  {
                      q.push(point(p.x+1, p.y, p.time+1));
                      map[p.x+1][p.y] = 1;
                  }
                  if(p.y < m-1 && map[p.x][p.y+1] != 1)
                  {
                      q.push(point(p.x, p.y+1, p.time+1));
                      map[p.x][p.y+1] = 1;
                  }
              }
              return INT_MAX;
          }
      };

32. 回文（palindrome）。

  - [LeetCode] Longest Palindromic Substring 最长回文子串（子串连续）。Hint：方法一，中心扩展法，回文中心的两侧互为镜像，将每一个位置作为中心进行扩展，回文分偶数和奇数；方法二，动态规划，类似于矩阵连乘问题，逐渐增大步长。

      https://leetcode.com/problems/longest-palindromic-substring/

    .. math::
       :nowrap:

       $$
       dp[i][i] = true
       $$

       $$
       dp[i][j] =
       \begin{cases}
       true & &\ s[i] = s[j]\ \&\&\ (i \leqslant j \leqslant i+1\ ||\ dp[i+1][j-1] = true) \\
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
                           if(gap <= 1 || dp[i+1][j-1])
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

  - [LeetCode] Count Different Palindromic Subsequences 统计不同回文子序列的个数（子序列可以不连续）。

      https://leetcode.com/problems/count-different-palindromic-subsequences/

      https://leetcode.com/problems/count-different-palindromic-subsequences/discuss/272297/DP-C%2B%2B-Clear-solution-explained

      https://blog.csdn.net/lili0710432/article/details/78659583

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Analysis}`

    用 :math:`dp[i][j]` 表示字符串 :math:`[i,j]` 区间内的的回文子序列个数。

      - :math:`S[i] \ne S[j]` 。下式的第三项是前两项重复计算的部分。

        .. math::

          dp[i][j] = dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1]

      - :math:`S[i] = S[j]`

        - 如果相同的回文子序列可以多次统计，递推式如下。其中 :math:`+1` 统计的是长度为 2 的回文子序列 “ :math:`S[i]S[j]` ”；
          :math:`+ dp[i+1][j-1]` 统计的是以 “ :math:`S[i]` ”开头，以 “ :math:`S[j]` ”结尾，且中间部分取自区间 :math:`[i+1,j-1]` 的回文子序列。

          .. math::

            dp[i][j] & = &\ dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1] + 1 + dp[i+1][j-1] \\
                     & = &\ dp[i+1][j] + dp[i][j-1] + 1

        - 如果只统计不同回文子序列的个数，分三种情况。

            - 若 :math:`S[i]` 不再出现在区间 :math:`[i+1,j-1]` 内，递推式如下。其中 :math:`\times 2` 统计了两类回文子序列：一类是以 “ :math:`S[i]` ”开头，以 “ :math:`S[j]` ”结尾，且中间部分取自区间 :math:`[i+1,j-1]` 的回文子序列，另一类是只取自区间 :math:`[i+1,j-1]` 的回文子序列；
              :math:`+2` 统计的是长度为 1 的回文子序列 “ :math:`S[i]` ”和长度为 2 的回文子序列 “ :math:`S[i]S[j]` ”。

              .. math::

                dp[i][j] = dp[i+1][j-1] \times 2 + 2

            - 若 :math:`S[i]` 在区间 :math:`[i+1,j-1]` 内又出现 1 次，递推式如下。 :math:`+1` 统计的是长度为 2 的回文子序列 “ :math:`S[i]S[j]` ”，长度为 1 的回文子序列 “ :math:`S[i]` ”在区间 :math:`[i+1,j-1]` 内已经统计过了。

              .. math::

                dp[i][j] = dp[i+1][j-1] \times 2 + 1

            - 若 :math:`S[i]` 在区间 :math:`[i+1,j-1]` 内又出现多次，设出现的第一个位置是 :math:`l` ，最后一个位置是 :math:`r` ，递推式如下。这种情况下，以 “ :math:`S[i]` ”开头，以 “ :math:`S[j]` ”结尾，且中间部分取自区间 :math:`[i+1,j-1]` 的回文子序列也会被重复统计。

              .. math::

                dp[i][j] = dp[i+1][j-1] \times 2 - dp[l+1][r-1]

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int countPalindromicSubsequences(string S)
          {
              int n = S.size();
              if(n <= 1) return n;
              vector<vector<long long>> dp(n, vector<long long>(n, 0)); // long long 防止溢出
              for(int i = 0; i < n; ++i) dp[i][i] = 1;

              long long modulo = 1000000007;
              for(int gap = 1; gap < n; ++gap)
              {
                  for(int i = 0; i + gap < n; ++i)
                  {
                      int j = i + gap;
                      if(S[i] != S[j])
                      {
                          dp[i][j] = dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1];
                      }
                      else
                      {
                          dp[i][j] = dp[i+1][j-1] * 2; // 先计算这部分，避免后面重复计算
                          int left = i + 1;
                          int right = j - 1;
                          while(left < j && S[left] != S[i]) left++;
                          while(right > i && S[right] != S[i]) right--;

                          if(left > right) dp[i][j] += 2;
                          else if(left == right) dp[i][j] += 1;
                          else dp[i][j] -= dp[left+1][right-1];
                      }
                      dp[i][j] = (dp[i][j] + modulo) % modulo; // 前面有减法操作，因此 dp[i][j] 可能是负数
                  }
              }

              int res = dp[0][n-1];
              dp.clear();
              dp.shrink_to_fit();
              return res;
          }
      };

  - [LeetCode] Palindrome Partitioning 分割字符串使所有的子串都是回文子串。Hint：回溯，从字符串起始位置往后判断回文，如果满足回文，加入子串集合，并从回文结束位置往后遍历。

      https://leetcode.com/problems/palindrome-partitioning/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          vector<vector<string>> partition(string s)
          {
              vector<vector<string>> res;
              if(s.empty()) return res;

              // isPalindrome[i][j] 表示 s 的区间 [i,j] 是否是回文
              vector<vector<bool>> isPalindrome(s.size(), vector<bool>(s.size(), false));
              for(int gap = 0; gap < s.size(); ++gap)
              {
                  for(int i = 0; i+gap < s.size(); ++i)
                  {
                      int j = i + gap;
                      if(s[i] == s[j])
                      {
                          if(gap <= 1) isPalindrome[i][j] = true;
                          else isPalindrome[i][j] = isPalindrome[i+1][j-1];
                      }
                      else isPalindrome[i][j] = false;
                  }
              }

              vector<string> tmp;
              dfs(s, 0, tmp, res, isPalindrome);

              isPalindrome.clear();
              isPalindrome.shrink_to_fit();

              return res;
          }
      private:
          void dfs(string& s, int t, vector<string>& tmp, vector<vector<string>>& res, vector<vector<bool>>& isPalindrome)
          {
              if(t == s.size())
              {
                  res.push_back(tmp);
                  return;
              }
              for(int i = t; i < s.size(); ++i)
              {
                  if(isPalindrome[t][i])
                  {
                      tmp.push_back(s.substr(t, i-t+1)); // 如果满足回文，加入当前子串集合
                      dfs(s, i+1, tmp, res, isPalindrome); // 回文结束位置为 i，因此下一个起始位置是 i+1
                      tmp.pop_back();
                  }
              }
          }
      };

  - [LeetCode] Palindrome Partitioning II 找出最短回文分割。Hint：如果采用上题方法，会超时；使用动态规划，类似于最长上升子序列的解法。

      https://leetcode.com/problems/palindrome-partitioning-ii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution {
      public:
          int minCut(string s) {
              if(s.size() <= 1) return 0;

              vector<vector<bool>> isPalindrome(s.size(), vector<bool>(s.size(), false));
              for(int gap = 0; gap < s.size(); ++gap)
              {
                  for(int i = 0; i+gap < s.size(); ++i)
                  {
                      int j = i + gap;
                      if(s[i] == s[j])
                      {
                          if(gap <= 1) isPalindrome[i][j] = true;
                          else isPalindrome[i][j] = isPalindrome[i+1][j-1];
                      }
                      else isPalindrome[i][j] = false;
                  }
              }

              vector<int> dp(s.size(), 0); // dp[i] 表示区间 [0, i] 的最短回文分割
              for(int i = 1; i < s.size(); ++i)
              {
                  if(isPalindrome[0][i]) dp[i] = 0;
                  else
                  {
                      dp[i] = dp[i-1] + 1; // 直接划分 s[i] 为一个子串
                      for(int j = 1; j < i; ++j)
                      {
                          if(isPalindrome[j][i]) dp[i] = min(dp[i], dp[j-1] + 1); // [j, i] 为一个子串
                      }
                  }
              }

              int res = dp[s.size()-1];

              isPalindrome.clear(); isPalindrome.shrink_to_fit();
              dp.clear(); dp.shrink_to_fit();

              return res;
          }

      };

33. 给定两个字符串 s1 和 s2，检查 s2 是否由 s1 旋转得到。Hint：对 s1 做循环移位，所得字符串都将是字符串 s1s1 的子串。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      bool checkReverseEqual(string s1, string s2)
      {
          if(s1.size()==0 || s2.size()==0) return false;
          if(s1.size() < s2.size()) return false; // s1 = "abc", s2 = "abcabc"
          string s1s1 = s1 + s1;
          if(s1s1.find(s2) == string::npos) return false;
          return true;
      }

34. [LeetCode] Validate Binary Search Tree 检查一棵二叉树是否为二叉查找树。Hint：不仅要求左节点比当前节点小，右节点比当前节点大，而是要求左子树所有节点都小于当前节点，右子树所有节点都大于当前节点；利用二叉树的中序遍历，BST 得到的序列是升序排列的。

  https://leetcode.com/problems/validate-binary-search-tree/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
        bool isValidBST(TreeNode* root)
        {
          // 节点的值 val 是 int 型
          long long pre = (long long)(INT_MIN) - 1;
          return checkBST(root, pre);
        }
      private:
        // 中序遍历，检查上一个遍历的数是否小于当前数, O(1) 空间复杂度
        bool checkBST(TreeNode* root, long long& pre)
        {
          if(!root) return true;
          if(!checkBST(root -> left, pre)) return false;
          if(pre >= (long long)(root -> val)) return false;
          pre = (long long)(root -> val);
          return checkBST(root -> right, pre);
        }
      };

35. 判断一个数是否是奇数。Hint：考虑负数的情形；方法一，判断模 2 结果不为 0；方法二，位运算判断最低位为 1。延伸：判断两个数是否相等（或判断某个数是否为 0），
如果是浮点数，应该判断两者差的绝对值是否小于一个阈值，而不是直接使用 ==。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      bool isOdd1(int x)
      {
        return (x % 2) != 0;
      }

      bool isOdd2(int x)
      {
        return (x & 1) == 1;
      }

      bool isEqual(double x, double y)
      {
        return fabs(x - y) < 1e-6;
      }


36. [LeetCode] Valid Number 验证一个字符串是否表示某个有效数字。Hint：完整的数字表达是“空格+正负号+整数+小数点+整数+e+正负号+整数+空格”；小数点的相邻两边至少要有一边是整数；如果出现 e，其两边都必须出现整数，但不要求相邻；如 05.e-3 是一个有效数字。
    延伸：将字符串转换为整数，需要考虑：空串、正负号、无效字符、溢出。

  https://leetcode.com/problems/valid-number/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 验证一个字符串是否表示某个有效数字
      class Solution
      {
      public:
          bool isNumber(string s)
          {
              size_t idx = 0;
              bool hasDigit = false;

              scanSpace(s, idx);
              scanSign(s, idx);
              hasDigit = scanDigit(s, idx);
              scanPoint(s, idx);
              hasDigit |= scanDigit(s, idx);
              if(hasDigit) // 小数点的相邻两边至少要有一边是整数；e 的左边必须出现整数；如果既没有小数点，又没有 e，则要求该字符串中必须包含整数。总而言之，这里必须是 true 才有可能是有效数字
              {
                  if(scanExp(s, idx))
                  {
                      scanSign(s, idx);
                      hasDigit = scanDigit(s, idx); // e 的右边必须出现整数
                  }
                  scanSpace(s, idx);
                  if(idx == s.size() && hasDigit) return true;
              }
              return false;
          }
      private:
          void scanSpace(string& s, size_t& idx)
          {
              while(idx < s.size() && s.at(idx) == ' ') ++idx;
          }
          void scanSign(string& s, size_t& idx)
          {
              if(idx < s.size() && (s.at(idx) == '+' || s.at(idx) == '-')) ++idx;
          }
          bool scanDigit(string& s, size_t& idx)
          {
              if(idx >= s.size()) return false;
              if(s.at(idx) < '0' || s.at(idx) > '9') return false;
              while(idx < s.size() && '0' <= s.at(idx) && s.at(idx) <= '9') ++idx;
              return true;
          }
          void scanPoint(string& s, size_t& idx)
          {
              if(idx < s.size() && s.at(idx) == '.') ++idx;
          }
          bool scanExp(string& s, size_t& idx)
          {
              if(idx < s.size() && s.at(idx) == 'e')
              {
                  ++idx;
                  return true;
              }
              return false;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 将字符串转换为整数
      class Solution
      {
      public:
          int myAtoi(string str)
          {
              unsigned int idx = 0;
              scanSpace(str, idx);

              bool sign = true;
              if(idx < str.size() && str[idx] == '-' || str[idx] == '+')
              {
                  if(str[idx] == '-') sign = false;
                  ++idx;
              }

              long long ans = 0;
              bool hasDigit = false;
              while(idx < str.size() && '0' <= str[idx] && str[idx] <= '9')
              {
                  hasDigit = true;
                  ans = 10 * ans + str[idx] - '0';
                  if(sign && ans > INT_MAX)
                  {
                      validInt = false;
                      return INT_MAX;
                  }
                  if(!sign && -ans < INT_MIN)
                  {
                      validInt = false;
                      return INT_MIN;
                  }
                  ++idx;
              }
              scanSpace(str, idx);
              if(idx == str.size() && hasDigit)
              {
                  if(!sign) ans = - ans;
                  validInt = true;
                  return static_cast<int>(ans);
              }

              validInt = false;
              return 0;
          }
      private:
          bool validInt; // 标志符，输出 0 / INT_MAX / INT_MIN 时，有可能是异常情形
          void scanSpace(string str, unsigned int& idx) // 扫描首尾空格
          {
              while(idx < str.size() && str[idx] == ' ') ++idx;
          }
      };

37. 求 :math:`1+2+3+ \cdots +n` ，不使用：乘除法，判断，循环，库函数。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一，构造函数
      class A
      {
      public:
        A()
        {
          id++;
          sum += id;
        }
        static void reset()
        {
          id = 0;
          sum = 0;
        }
        static unsigned int getSum()
        {
          return sum;
        }
      private:
        static unsigned int id;
        static unsigned int sum;
      };

      unsigned int A::id = 0;
      unsigned int A::sum = 0;

      unsigned int sumFrom1ToN(unsigned int N)
      {
        A::reset();

        A* arr = new A[N];
        delete[] arr;

        return A::getSum();
      }

    .. code-block:: cpp
      :linenos:

      // 方法二，虚函数

      class A; // 前向声明
      A* arr[2]; // 这里可以声明类 A 的指针，但是不能声明类 A 的变量，类 A 还未定义

      class A
      {
      public:
        virtual unsigned int getSum(unsigned int n)
        {
          return 0;
        }
      };

      class B: public A
      {
      public:
        unsigned int getSum(unsigned int n) override
        {
          return n + arr[!!n] -> getSum(n - 1); // !!n：当 n>0，arr[1] 调用 B::getSum(n)；当 n=0，arr[0] 调用 A::getSum(n)
        }
      };

      unsigned int sumFrom1ToN(unsigned int N)
      {
        A a;
        B b;
        arr[0] = &a;
        arr[1] = &b;
        return arr[1] -> getSum(N);
      }

38. [LeetCode] Lexicographical Numbers 按字典序排列 :math:`1 \sim n` 。Hint：方法一，定义排序规则，按字符串的字典序排序；方法二，回溯，递归深度只与 :math:`n` 的位数有关。

  https://leetcode.com/problems/lexicographical-numbers/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一，定义排序规则

      class Solution
      {
      public:
          vector<int> lexicalOrder(int n)
          {
              vector<int> res;
              if(n < 1) return res;
              res.resize(n);
              iota(res.begin(), res.end(), 1);
              sort(res.begin(), res.end(), comparator);
              return res;
          }
      private:
          static bool comparator(int x, int y)
          {
              return strcmp(to_string(x).c_str(), to_string(y).c_str()) < 0 ? true: false;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 方法二，回溯，从高位往低位进行

      class Solution
      {
      public:
          vector<int> lexicalOrder(int n)
          {
              vector<int> res;
              for(int high = 1; high <= 9; ++high) DFS(high, n, res); // 最高位不能为 0
              return res;
          }
      private:
          void DFS(int high, int n, vector<int>& res)
          {
              if(high > n) return;
              res.push_back(high); // 只有高位，没有低位。这是同一前缀的数字中最小的数
              for(int low = 0; low <= 9; ++low) DFS(high * 10 + low, n, res); // 高位 + 低位
          }
      };


39. [LeetCode] Merge k Sorted Lists 合并 :math:`k` 条有序链表为一条有序链表（都是升序）。Hint：建立大小为 :math:`k` 的小顶堆，每次弹出一个节点，并把该节点的下一个节点插入小顶堆中。时间复杂度 :math:`\mathcal{O}(n \log k)` ，:math:`n` 是节点个数。

  https://leetcode.com/problems/merge-k-sorted-lists/

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

      struct comparator
      {
          bool operator()(ListNode* a, ListNode* b)
          {
              return a -> val > b -> val; // 小顶堆
          }
      };

      class Solution
      {
      public:
          ListNode* mergeKLists(vector<ListNode*>& lists)
          {
              if(lists.size() == 0) return NULL;
              if(lists.size() == 1) return lists[0];

              ListNode* head = new ListNode(0); // 合并链表的临时头节点

              priority_queue<ListNode*, vector<ListNode*>, comparator> pq;
              for(auto & list : lists)
              {
                  if(list) pq.emplace(list); // 建堆
              }
              ListNode* curr = head;
              while(!pq.empty())
              {
                  ListNode* p = pq.top();
                  pq.pop();
                  curr -> next = p;
                  curr = p;
                  if(p -> next) pq.push(p -> next);
              }

              curr = head -> next;
              delete head;
              return curr;
          }
      };


40. [LeetCode] Max Points on a Line 统计共线的最多点数。Hint：直线需要考虑三种斜率：水平，垂直，斜线，还要考虑点重合的情形；由于浮点运算的精度问题，将斜率表示为两个整数的分数形式，保存到哈希表中。

  https://leetcode.com/problems/max-points-on-a-line/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int maxPoints(vector<vector<int>>& points)
          {
              int res = 0;
              for(size_t i = 0; i < points.size(); ++i) // points.size() == 0，返回 0；points.size() == 1，返回 1
              {
                  unordered_map<string, int> mp; // 对每个点 i 统计其与其他点所成直线的斜率。由于这些直线都通过点 i，因此斜率相同就表示共线
                  int samePointNum = 0;
                  int verticalLineNum = 0;
                  int horizontalLineNum = 0;
                  int slantLineNum = 0;
                  for(size_t j = i + 1; j < points.size(); ++j) // 往后遍历每个点
                  {
                      if(points[i][0] == points[j][0] && points[i][1] == points[j][1]) ++samePointNum; // 点重合
                      else if(points[i][0] == points[j][0]) ++verticalLineNum; // 垂直线
                      else if(points[i][1] == points[j][1]) ++horizontalLineNum; // 水平线，可以计算斜率，但是由于垂直方向差异为 0，不好计算公约数
                      else // 斜线
                      {
                          int dx = points[j][0] - points[i][0];
                          int dy = points[j][1] - points[i][1];
                          int g = _gcd(dy, dx);
                          dx /= g;
                          dy /= g;
                          if(dy < 0) // 符号统一令 dy > 0
                          {
                              dy = -dy;
                              dx = -dx;
                          }
                          stringstream ss;
                          ss << dx << " " << dy;
                          string slope = ss.str();
                          ss.clear();
                          if(mp.find(slope) == mp.end()) mp[slope] = 1;
                          else ++mp[slope];
                          slantLineNum = max(slantLineNum, mp[slope]);
                      }
                  }

                  int currMax = max(slantLineNum, max(verticalLineNum, horizontalLineNum));
                  currMax += samePointNum + 1; // + 1 表示点 i 本身
                  res = max(res, currMax);
              }
              return res;
          }
      private:
          int _gcd(int a, int b) // 辗转相除，计算最大公约数
          {
              a = abs(a);
              b = abs(b);
              if(a < b) swap(a, b);
              while(a % b)
              {
                  int tmp = a;
                  a = b;
                  b = tmp % b;
              }
              return b;
          }
      };

41. [LeetCode] Word Break 字符串按字典切分。Hint：回溯；动态规划。

  https://leetcode.com/problems/word-break/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一，回溯
      // 测试用例超时
      // "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab" ["a","aa","aaa","aaaa","aaaaa","aaaaaa","aaaaaaa","aaaaaaaa","aaaaaaaaa","aaaaaaaaaa"]

      class Solution
      {
      public:
          bool wordBreak(string s, vector<string>& wordDict)
          {
              if(s=="") return true;
              if(wordDict.size()==0) return false;
              return word_find(s, wordDict, 0);
          }
      private:
          bool word_find(string& s, vector<string>& wordDict, int k)
          {
              if(k==s.size()) return true;
              for(int w = 0; w < wordDict.size(); ++w)
              {
                  if(k+wordDict[w].size()<=s.size() && s.substr(k, wordDict[w].size()) == wordDict[w])
                  {
                      if(word_find(s, wordDict, k + wordDict[w].size())) return true;
                  }
              }
              return false;
          }
      };


    .. code-block:: cpp
      :linenos:

      // 方法二，动态规划，空间复杂度 O(n^2)
      // dp[i][j] 表示字符串区间 [i, j] 的切分情况
      // 解法类似于矩阵连乘问题

      class Solution
      {
      public:
          bool wordBreak(string s, vector<string>& wordDict)
          {
              if(s.empty() || wordDict.empty()) return false;
              int n = s.size();
              vector<vector<bool>> dp(n, vector<bool>(n, false));
              for(int gap = 0; gap < n; ++gap)
              {
                  for(int i = 0; i + gap < n; ++i)
                  {
                      int j = i + gap;
                      for(string& word: wordDict)
                      {
                          // 这里用 ||，只要有一个 word 匹配就行
                          if(gap + 1 == word.size()) dp[i][j] = dp[i][j] || (s.substr(i, word.size()) == word);
                          else if(gap + 1 > word.size()) dp[i][j] = dp[i][j] || (s.substr(i, word.size()) == word && dp[i+word.size()][j]);
                      }
                  }
              }
              return dp[0][n-1];
          }
      };


    .. code-block:: cpp
      :linenos:

      // 方法三，动态规划，空间复杂度 O(n)
      // dp[i] 表示字符串区间 [0, i-1] 的切分情况

      class Solution {
      public:
          bool wordBreak(string s, vector<string>& wordDict) {
              if(s.empty() || wordDict.empty()) return false;

              int n = s.size();
              vector<bool> dp(n+1, false);
              dp[0] = true; // 初始化

              for(unsigned int i = 1; i <= n; ++i)
              {
                 for(unsigned int j = 0; j < i; ++j)
                 {
                     if(dp[j]) // 两段子串：[0, j-1], [j, i]
                     {
                         string str = s.substr(j, i-j);
                         for(string& word: wordDict)
                         {
                             if(str == word)
                             {
                                 dp[i] = true;
                                 break;
                             }
                         }
                     }
                 }
              }
              return dp[n];
          }
      };


42. [LeetCode] Gas Station 加油站回路。Hint：只要 gas 总和不小于 cost 总和，一定存在可以完成回路的出发点。延伸：从起点到终点的最少加油次数。Hint：贪心算法，把路过的每个加油站的油量存入优先队列，当需要加油时，
弹出队列中的最大油量。

  https://leetcode.com/problems/gas-station/

  https://leetcode.com/problems/gas-station/discuss/191463/topic

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int canCompleteCircuit(vector<int>& gas, vector<int>& cost)
          {
              if(gas.size() == 0) return -1;
              int totalDiff = 0;
              int currDiff = 0;
              int start = 0;
              for(int i = 0; i < gas.size(); ++i)
              {
                  totalDiff += gas[i] - cost[i];
                  currDiff += gas[i] - cost[i];
                  if(currDiff < 0)
                  {
                      start = i + 1; // 第 0 ~ i 加油站都不可能是可以完成回路的起始点
                      currDiff = 0;
                  }
              }
              return totalDiff >= 0 ? start: -1;
          }
      };

43. :math:`n` 个人过桥，每次最多通过两个人（过桥时间按较长者计算），只有一个手电筒，每次过桥之后需要一个人把手电筒送回来，求最短过桥时间。Hint：耗时第 :math:`k` 小的人过桥有两种方案，第一，由耗时最短的人送回手电筒，并陪同过河；
第二，耗时最短的人送回手电筒之后，耗时第 :math:`k` 小的人与耗时第 :math:`k-1` 小的人一起过桥，他们过桥之后，手电筒再由耗时第二短的人送回，最后耗时最短的人和耗时第二短的人一起过桥。

  https://blog.csdn.net/u014113686/article/details/82464635

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      int minTimeCrossBridge(int* Time, int n)
      {
          assert(n > 0);
          sort(Time, Time + n);
          int* dp = new int[n];
          dp[0] = Time[0];
          dp[1] = Time[1];
          for (size_t i = 2; i < n; ++i)
          {
              dp[i] = min(dp[i - 1] + Time[0] + Time[i], dp[i - 2] + Time[i] + Time[0] + 2 * Time[1]);
          }
          int res = dp[n - 1];
          delete[] dp;
          return res;
      }


44. [LeetCode] Minimum Window Substring 字符串 S 中包含字符串 T 中所有字符（可能会重复）的最短子串。Hint：用两个指针表示滑动窗口的起始和结尾；当窗口满足要求，则计算当前窗口的长度，然后两个指针都往后移动一步；终止条件是尾指针移动到了字符串 S 的结尾（'\\0'）。
延伸：不考虑字符串 T 中重复的字符，求字符串 S 中包含字符串 T 中出现的字符的最短子串。

  https://leetcode.com/problems/minimum-window-substring/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 考虑重复

      typedef unsigned int uint;
      class Solution
      {
      public:
          string minWindow(string s, string t)
          {
              uint lenS = s.size();
              uint lenT = t.size();
              if(lenS < lenT || lenT == 0) return "";

              uint hashT[256] = {0};
              for(size_t k = 0; k < lenT; ++k)
              {
                  hashT[t[k]] += 1; // 统计 T 中的字符，考虑重复
              }
              uint hashWindow[256] = {0}; // 统计 S 的滑动窗口中出现在 T 中的字符

              uint start = 0;
              uint minLen = lenS + 1;
              uint pBegin = 0;
              uint pEnd = -1; // 双指针初始化
              uint matchCnt = 0; // 统计当前滑动窗口中匹配的字符对
              while(true)
              {
                  if(matchCnt == lenT) //  T 中所有字符都出现
                  {
                      while(hashT[s[pBegin]] == 0 || hashWindow[s[pBegin]] > hashT[s[pBegin]]) // 收紧窗口的左端，第二个条件表示窗口中包含了多余的重复字符
                      {
                          --hashWindow[s[pBegin]];
                          ++pBegin;
                      }
                      if(pEnd - pBegin + 1 < minLen)
                      {
                          minLen = pEnd - pBegin + 1;
                          start = pBegin;
                      }
                      --matchCnt;
                      --hashWindow[s[pBegin]];
                      ++pBegin; // 起始指针往后移动，相应统计量 -1
                  }
                  ++pEnd;
                  if(pEnd == lenS) break;
                  if(hashT[s[pEnd]] > 0)
                  {
                      if(hashWindow[s[pEnd]] < hashT[s[pEnd]]) ++matchCnt; // 判断，不能匹配多余的重复字符
                      ++hashWindow[s[pEnd]];
                  }
              }
              if(minLen == lenS + 1) return "";
              else return s.substr(start, minLen);
          }
      };

    .. code-block:: cpp
      :linenos:

      // 不考虑重复

      typedef unsigned int uint;
      class Solution
      {
      public:
          string minWindow(string s, string t)
          {
              uint lenS = s.size();
              uint lenT = t.size();
              if (lenS < lenT || lenT == 0) return "";

              uint hashT[256] = { 0 };
              uint uniqueChar = 0;
              for (size_t k = 0; k < lenT; ++k)
              {
                  if (hashT[t[k]] == 0) uniqueChar += 1; // 统计 T 中的字符，不考虑重复
                  hashT[t[k]] = 1; // 不管出现多少次，都是 1
              }
              uint hashWindow[256] = { 0 };

              uint start = 0;
              uint minLen = lenS + 1;
              uint pBegin = 0;
              uint pEnd = -1;
              uint matchCnt = 0;
              while (true)
              {
                  if (matchCnt == uniqueChar) // 匹配了 T 中所有字符
                  {
                      while (hashT[s[pBegin]] == 0 || hashWindow[s[pBegin]] > 1) // 收紧窗口的左端，第二个条件表示窗口中包含了多余的重复字符
                      {
                          --hashWindow[s[pBegin]];
                          ++pBegin;
                      }
                      if (pEnd - pBegin + 1 < minLen)
                      {
                          minLen = pEnd - pBegin + 1;
                          start = pBegin;
                      }
                      --matchCnt;
                      --hashWindow[s[pBegin]];
                      ++pBegin; // 起始指针往后移动，相应统计量 -1
                  }
                  ++pEnd;
                  if (pEnd == lenS) break;
                  if (hashT[s[pEnd]] > 0)
                  {
                      if (hashWindow[s[pEnd]] == 0) ++matchCnt; // 新增匹配
                      ++hashWindow[s[pEnd]];
                  }
              }
              if (minLen == lenS + 1) return "";
              else return s.substr(start, minLen);
          }
      };


45. [LeetCode] Nth Digit 第 :math:`N` 个数字。Hint：:math:`k` 位数的个数是 :math:`9 \times 10^{k-1}` ，例如，两位数有 :math:`90` 个；
先确定第 :math:`N` 个数字是几位数，再定位到具体的数，取出相应数字。

  https://leetcode.com/problems/nth-digit/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int findNthDigit(int n)
          {
              int sum = 0;
              int k = 1;
              while(sum + k*9*pow(10, k-1) < n)
              {
                  sum += k*9*pow(10, k-1);
                  k ++;
              }
              int a = (n - sum) / k;
              int b = (n - sum) % k;
              int num = pow(10, k-1) + a - 1; // 定位到具体的数
              if(b == 0) return num % 10; // 当前数的最后一位数字（个位）
              else return ((num + 1) / static_cast<int>(pow(10, k-b))) % 10; // 下一个数的第 b 位数字
          }
      };


46. [LeetCode] Pow(x, n) 求幂。Hint：:math:`x^{2k} = x^k \times x^k,\ x^{2k+1} = x \times x^k \times x^k` 。

  https://leetcode.com/problems/powx-n/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 递归

      double myPow(double x, int n)
      {
          if(fabs(x) < 1e-7)
          {
              if(n < 0) throw logic_error("ZeroDivisionError"); // 底数为 0， 指数为负
              return 1.0;
          }
          if(n == 0) return 1;
          if(n == 1) return x;
          if(n < 0)
          {
              if(n == INT_MIN) return 1/x * myPow(1/x, - (n + 1)); // - INT_MIN 溢出
              else return myPow(1/x, - n);
          }
          double tmp = myPow(x, n/2);
          if(n % 2) return x * tmp * tmp;
          else return tmp * tmp;
      }

    .. code-block:: cpp
      :linenos:

      // 迭代

      double myPow(double x, int n)
      {
          if(fabs(x) < 1e-7)
          {
              if(n < 0) throw logic_error("ZeroDivisionError"); // 底数为 0， 指数为负
              return 1.0;
          }

          if(n == 0) return 1.0;
          if(n == 1) return x;

          double ans = 1.0;

          if(n < 0)
          {
              x = 1/x;
              if(n == INT_MIN) // - INT_MIN 溢出
              {
                  ans *= x;
                  n = INT_MAX;
              }
              else n = - n;
          }

          while(n > 0)
          {
              int k = 1;
              double tmp = x;
              while(k <= n/2)
              {
                  tmp *= tmp;
                  k <<= 1;
              }
              n -= k;
              ans *= tmp;
          }

          return ans;
      }

47. [LeetCode] Longest Valid Parentheses 最长有效匹配括号长度。

  https://leetcode.com/problems/longest-valid-parentheses/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 设 dp[i] 表示以 s[i] 结尾的最长匹配长度
      // 当 s[i] = '(' ，dp[i] = 0
      // 当 s[i] = ')' 且 s[i-1] = '(' ，dp[i] = dp[i-2] + 2
      // 当 s[i] = ')' 且 s[i-1] = ')' ，需要找到与 s[i] 匹配的左括号的位置，而以 s[i-1] 结尾的最长匹配组的长度为 dp[i-1]，
      // 因此与 s[i] 匹配的位置为 i - 1 - dp[i-1]

      class Solution
      {
      public:
          int longestValidParentheses(string s)
          {
              if(s.size() <= 1) return 0;
              vector<int> dp(s.size(), 0);
              int res = 0;
              for(int i = 1; i < s.size(); ++i)
              {
                  if(s[i] == ')' && s[i-1] == '(')
                  {
                      dp[i] = i-2 >= 0 ? dp[i-2] + 2 : 2;
                  }
                  else if(s[i] == ')' && s[i-1] == ')')
                  {
                      int left = i - 1 - dp[i-1];
                      if(left >= 0 && s[left] == '(')
                      {
                          dp[i] = left > 0 ? dp[left-1] + dp[i-1] + 2 : dp[i-1] + 2;
                      }
                  }
                  res = max(res, dp[i]);
              }
              vector<int>().swap(dp);
              return res;
          }
      };


48. 从 :math:`1,2,...,n` 中取丢弃 :math:`k` 个数，剩余的数形成一个数组 :math:`arr` ，求出丢弃的数。

  - :math:`k=1` 。Hint：:math:`a = \sum_{i=1}^n i - \sum arr` 。

  - :math:`k=2` 。Hint：:math:`a + b = \sum_{i=1}^n i - \sum arr,\ a \times b = n! / \prod arr` ；考虑到连乘可能溢出，可以使用平方和 :math:`a^2 + b^2 = \sum_{i=1}^n i^2 - \sum arr^2` 。

49. [LeetCode] Trapping Rain Water 接雨水。Hint：方法一，水从地面往上溢，统计每一层的积水，时间复杂度 :math:`\mathcal{O}(NH_{max})` ；方法二，双指针，当左高右低，推进右边的指针，当左低右高，推进左边的指针。

  https://leetcode.com/problems/trapping-rain-water/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一

      class Solution
      {
      public:
          int trap(vector<int>& height)
          {
              if(height.size() <= 1) return 0;

              int maxh = *max_element(height.begin(), height.end());
              int ans = 0;
              for(int h = 1; h <= maxh; ++h)
              {
                  vector<int> idx;
                  for(int i = 0; i < height.size(); ++i)
                  {
                      if(height[i] >= h) idx.push_back(i); // 找到所有会积水的区间
                  }
                  if(idx.size() < 2) break;
                  for(int j = 0; j < idx.size() - 1; ++j)
                  {
                      ans += idx[j+1] - idx[j] - 1; // 第 h 层的积水量
                  }
              }
              return ans;
          }
      };


    .. code-block:: cpp
      :linenos:

      // 方法二

      class Solution
      {
      public:
          int trap(vector<int>& height)
          {
              if(height.size() <= 1) return 0;

              int ans = 0;

              int left = 0;
              int leftmax = height[0];
              int right = height.size() - 1;
              int rightmax = height[right];
              while(left < right)
              {
                  if(height[left] < height[right]) // 左低右高
                  {
                      if(height[left] <= leftmax)
                      {
                          ans += leftmax - height[left];
                          ++left;
                      }
                      else leftmax = height[left];
                  }
                  else // 左高右低
                  {
                      if(height[right] <= rightmax)
                      {
                          ans += rightmax - height[right];
                          --right;
                      }
                      else rightmax = height[right];
                  }
              }
              return ans;
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

4. C++ STL中vector内存用尽后，为啥每次是两倍的增长，而不是3倍或其他数值？Hint：:math:`1 + 2 + 1 + 4 + 1 + 1 + 1 + 8 + \cdots + n = \mathcal{O}(n)` ，每一次 push_back 操作的摊还代价为 :math:`\mathcal{O}(1)` 。

  https://www.zhihu.com/question/36538542

5. 常见C++笔试面试题整理

  https://zhuanlan.zhihu.com/p/69999591

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

  https://blog.csdn.net/diamonjoy_zone/article/details/70576775

3. ResNeXt

  - ResNeXt

      https://www.cnblogs.com/bonelee/p/9031639.html

  - ResNeXt算法详解

      https://blog.csdn.net/u014380165/article/details/71667916

4. R-CNN系列

  - RCNN（三）：Fast R-CNN

      https://blog.csdn.net/u011587569/article/details/52151871

  - 一文读懂Faster RCNN

      https://zhuanlan.zhihu.com/p/31426458

  - 【RCNN系列】【超详细解析】

      https://blog.csdn.net/amor_tila/article/details/78809791

  - 实例分割模型Mask R-CNN详解：从R-CNN，Fast R-CNN，Faster R-CNN再到Mask R-CNN

      https://blog.csdn.net/jiongnima/article/details/79094159

  - (Mask RCNN)——论文详解(真的很详细)

      https://blog.csdn.net/wangdongwei0/article/details/83110305

  - ROI-Align 原理理解

      https://blog.csdn.net/gusui7202/article/details/84799535

  - 为什么RCNN用SVM做分类而不直接用CNN全连接之后softmax输出？

      https://www.zhihu.com/question/54117650


5. Focal Loss（样本不均衡：正/负样本数量不均衡（ :math:`\alpha` ），简单/困难样本数量不均衡（ :math:`\gamma` ））

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


6. FCN（Fully Convolutional Networks）

  - FCN学习:Semantic Segmentation

      https://zhuanlan.zhihu.com/p/22976342?utm_source=tuicool&utm_medium=referral

  - FCN于反卷积(Deconvolution)、上采样(UpSampling)

      https://blog.csdn.net/nijiayan123/article/details/79416764

7. FPN（Feature Pyramid Networks for Object Detection）

  https://www.cnblogs.com/fangpengchengbupter/p/7681683.html

8. CapsuleNet解读

  https://blog.csdn.net/u013010889/article/details/78722140/


9. 轻量级网络--MobileNet论文解读

  https://blog.csdn.net/u011974639/article/details/79199306

10. 一文读懂卷积神经网络中的1x1卷积核。Hint：升维、降维、跨通道信息交互。

  https://zhuanlan.zhihu.com/p/40050371

11. Image Classification Architectures

  - 模型，FLOP（浮点计算量），性能，参数量（表格中的参数量单位是字节，按 4 字节/浮点型数计算，需要除以 4 才得到参数个数）

      https://github.com/albanie/convnet-burden#convnet-burden

  - torchvision.models

      https://pytorch.org/docs/stable/torchvision/models.html

其他
--------------

1. 理解数据库的事务，ACID，CAP和一致性

  https://www.jianshu.com/p/2c30d1fe5c4e
