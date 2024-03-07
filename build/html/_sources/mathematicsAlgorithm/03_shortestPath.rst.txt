最短路径
=============

Bellman-Ford 算法
---------------------------

时间复杂度 :math:`\mathcal{O}(VE)` 其中顶点数 :math:`V` ，边数 :math:`E` 。如果不存在负圈（一条回路的代价和为负），那么每一条最短路径都不会经过同一个顶点两次，因此 while 循环最多执行 :math:`V-1` 次。

.. code-block:: cpp
  :linenos:

  struct edge {int from, to, cost;};

  edge es[MAX_E];

  int d[MAX_V]; // 最短距离
  int V, E; // 顶点数，边数

  // 从顶点 s 出发的最短距离（假设不存在负圈）
  void shortestPath(int s)
  {
    fill(d, d+V, INF);
    d[s] = 0;
    while(true)
    {
      bool update = false;
      for(int i = 0; i < E; ++i)
      {
        edge e = es[i];
        if(d[e.from] != INF && d[e.to] > d[e.from] + e.cost)
        {
          d[e.to] = d[e.from] + e.cost;
          update = true;
        }
      }
      if(!update) break;
    }
  }


检查负圈：如果第 :math:`V` 次循环还有更新，则表明存在负圈，返回 true。

.. code-block:: cpp
  :linenos:

  bool findNegativeLoop()
  {
    fill(d, d+V, 0); // 初始化为 0，防止因为是 d[e.from] == INF 而停止更新
    for(int i = 0; i < V; ++i)
    {
      for(int j = 0; j < E; ++j)
      {
        edge e = es[j];
        if(d[e.to] > d[e.from] + e.cost)
        {
          d[e.to] = d[e.from] + e.cost;
          if(i == V-1) return true;
        }
      }
    }
    return false;
  }


Dijkstra 算法
-------------------

适合处理没有负边的情形。每一次循环，在尚未确定最短距离的顶点中，d[i] 最小的顶点就是下一个确定的顶点。但是如果存在负边，d[i] 在之后的更新中还会变小，因此算法失效。

- 方法一
    直接使用邻接矩阵，时间复杂度 :math:`\mathcal{O}(V^2)` 。

.. code-block:: cpp
  :linenos:

  int cost[MAX_V][MAX_V];
  int d[MAX_V];
  bool used[MAX_V];
  int V;

  void dijkstra(int s)
  {
    fill(d, d+V, INF);
    d[s] = 0;
    fill(used, used+V, false);

    while(true)
    {
      int v = -1;
      for(int u = 0; u < V; ++u)
      {
        if(!used[u] && (v == -1 || d[u] < d[v])) v = u;
      }

      if(v == -1 || d[v] == INF) break;
      // v == -1 表示所有顶点都找到了最短距离
      // d[v] == INF 表示后面所有的顶点都已经不可达，直接结束循环

      used[v] = true;
      for(int u = 0; u < V; ++u)
      {
        d[u] = min(d[u], d[v] + cost[v][u]);
      }
    }
  }


- 方法二
    使用最小堆（优先队列），堆中元素个数为 :math:`\mathcal{O}(V)`，出队（弹出最小值）的次数为 :math:`\mathcal{O}(E)`，时间复杂度 :math:`\mathcal{O}(E \log V)`。

.. code-block:: cpp
  :linenos:

  struct edge {int to, cost;};
  typedef pair<int, int> P; // first：最短距离，second：顶点

  int V;
  vector<edge> G[MAX_V]; // 边
  int d[MAX_V];

  void dijkstra(int s)
  {
    priority_queue<P, vector<P>, greater<P>> que;

    fill(d, d+V, INF);
    d[s] = 0;

    que.push(P(0, s));
    while(!que.empty())
    {
      P p = que.top();
      que.pop();

      int v = p.second;
      if(d[v] < p.first) continue;

      for(int i = 0; i < G[v].size(); ++ i)
      {
        edge e = G[v][i];
        if(d[e.to] > d[v] + e.cost)
        {
          d[e.to] = d[v] + e.cost;
          que.push(P(d[e.to], e.to));
        }
      }
    }
  }


实例
-------------

- [LeetCode] Shortest Path to Get All Keys 获取所有钥匙的最短路径。Hint：需要一个状态量来表示到达当前位置已经获得的钥匙（BitMap）；当且仅当钥匙状态不相同时，才可以重复经过某一个坐标点。

  https://leetcode.com/problems/shortest-path-to-get-all-keys/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution 
      {
      public:
          int shortestPathAllKeys(vector<string>& grid) 
          {
              if(grid.empty() || grid[0].empty()) return 0;
              int row = grid.size();
              int col = grid[0].size();
              vector<vector<vector<bool>>> visited(row, vector<vector<bool>>(col, vector<bool>(64, false))); // bitmap, row x col x 2^6
              queue<pair<int,int>> que; // 坐标和key
              int nkey = 0;
              for(int i = 0; i < row; ++i)
              {
                  for(int j = 0; j < col; ++j)
                  {
                      if(grid[i][j] == '@')
                      {
                          que.push({i*col+j,0});
                          visited[i][j][0] = true;
                      }
                      if('a' <= grid[i][j] && grid[i][j] <= 'f') nkey |= 1 << (grid[i][j] - 'a');
                  }
              }
              int step = 0;
              while(!que.empty())
              {
                  int qsize = que.size();
                  for(int i = 0; i < qsize; ++i) // 从各个出发点出发，同步向前走一步
                  {
                      auto p = que.front();
                      que.pop();
                      int x = p.first/col, y = p.first%col;
                      int carry = p.second;
                      if(carry == nkey) return step;
                      for(int j = 0; j < 4; ++j)
                      {
                          int nx = x + mv[j][0];
                          int ny = y + mv[j][1];
                          int nk = carry;
                          if(nx < 0 || nx >= row || ny < 0 || ny >= col) continue;
                          if(grid[nx][ny] == '#') continue;
                          if('A' <= grid[nx][ny] && grid[nx][ny] <= 'F')
                          {
                              if(!(nk & (1 << (grid[nx][ny] - 'A')))) continue;
                              // nk &= ~ (1 << (grid[nx][ny] - 'A')); // 开门不会消耗钥匙
                          }
                          if('a' <= grid[nx][ny] && grid[nx][ny] <= 'f') nk |= 1 << (grid[nx][ny] - 'a');
                          if(!visited[nx][ny][nk]) // 当前钥匙状态为 nk , 未访问过 (nx, ny)
                          {
                              visited[nx][ny][nk] = true;
                              que.push({nx*col+ny, nk});
                          }
                      }
                  }
                  ++step; // 此时队列中保存的是从各个出发点出发，走完 step 步的结果
              }
              return -1;
          }
      private:
          static const int mv[4][2];
      };
      const int Solution::mv[4][2] = {{-1,0},{0,-1},{0,1},{1,0}};


- [LeetCode] 到达目的地的方案数。

  https://leetcode.cn/problems/number-of-ways-to-arrive-at-destination

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      from queue import PriorityQueue

      INF = float('inf')
      MOD = 10 ** 9 + 7

      class Solution:
          def countPaths(self, n: int, roads: List[List[int]]) -> int:
              adj = [[] for _ in range(n)] ## 邻接表
              for u, v, time in roads:
                  adj[u].append((v, time))
                  adj[v].append((u, time))
              d = [0] + [INF] * (n - 1) ## 最短距离
              pn = [1] + [0] * (n - 1) ## 最短路径数量
              pq = PriorityQueue()
              pq.put((0, 0)) ## (从起点到某顶点的距离，顶点)
              while not pq.empty():
                  t, u = pq.get()
                  if d[u] < t:
                      continue
                  for v, time in adj[u]:
                      if d[v] == d[u] + time:
                          pn[v] += pn[u]
                      elif d[v] > d[u] + time:
                          d[v] = d[u] + time
                          pn[v] = pn[u]
                          pq.put((d[u] + time, v)) ## 发现更短的路径才放入队列
                      pn[v] = pn[v] % MOD
              return pn[-1]

