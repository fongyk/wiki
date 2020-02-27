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
  void shortest_path(int s)
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

  bool find_negative_loop()
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
        if(!used[u] && (v==-1 || d[u] < d[v])) v = u;
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

- 耗时最短的路径：某些顶点有自行车，骑上自行车之后耗时减半。Hint：广度优先遍历，使用优先队列/堆，最早到达终点的一定是耗时最短路径。这里
  需要设置两个全局数组，一个记录当前顶点有自行车的最短耗时，另一个记录当前顶点没有自行车的最短耗时。

  https://www.nowcoder.com/practice/7689b595f3eb419b9e7816c4f45a400d?tpId=90&tqId=30852&tPage=4&rp=4&ru=/ta/2018test&qru=/ta/2018test/question-ranking

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      import sys
      import heapq as hq

      n, m = map(int, sys.stdin.readline().strip().split())
      edges = [[] for _ in range(n)]
      for _ in range(m):
          begin, end, cost = map(int, sys.stdin.readline().strip().split())
          begin -= 1
          end -= 1
          edges[begin].append((end, cost)) ## 无向边
          edges[end].append((begin, cost))
      have_bike = [False for _ in range(n)]
      k = int(sys.stdin.readline().strip())
      for _ in range(k):
          v = int(sys.stdin.readline().strip())
          v -= 1
          have_bike[v] = True

      INF = float('inf') ## 无穷大
      ## 根据当前顶点是否有自行车，需要定义两个全局数组，存储当前最短耗时
      global_cost = {False: [INF for _ in range(n)], True: [INF for _ in range(n)]}
      global_cost[have_bike[0]][0] = 0
      ans = -1
      h = []
      ## 堆元素：(cost, v, have_bike)
      hq.heappush(h, (0, 0, have_bike[0]))
      while len(h) > 0:
          v_cost, v, v_bike = hq.heappop(h)
          if v == n-1:
              ans = v_cost
              break
          for u, uv_cost in edges[v]:
              if v_bike:
                  uv_cost /= 2
              u_cost = v_cost + uv_cost
              u_bike = have_bike[u] or v_bike

              if u_cost >= global_cost[u_bike][u]:
                  continue
              global_cost[u_bike][u] = u_cost
              hq.heappush(h, (u_cost, u, u_bike))

      print ans
