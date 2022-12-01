拓扑排序
============

AOV 网
---------

AOV 网（Activity On Vertex Network）：一个有向图，顶点表示活动，有向边表示活动之间的优先关系。

若顶点 :math:`u` 与顶点 :math:`v` 之间存在一条弧 :math:`<u, v>` ，则表示活动 :math:`u` 必须优先于活动 :math:`v` 完成，称 :math:`u` 为 :math:`v` 的直接前驱，:math:`v` 为 :math:`u` 的直接后继。


拓扑序列
------------

设 :math:`G=(V, E)` 是一个 :math:`n` 个顶点的有向图，:math:`V` 中的顶点序列 :math:`[v_1,v_2,...,v_n]` 称为一个拓扑序列当且仅当满足下列条件：若从顶点 :math:`v_i` 到 :math:`v_j` 有路径，则在该顶点
序列中顶点 :math:`v_i` 必在 :math:`v_j` 之前。

一个 AOV 网的拓扑序列可能不唯一。

拓扑排序
------------

算法：

  - Step 1：在 AOV 网中任选一个入度为 0 的顶点（没有直接前驱），输出该顶点；

  - Step 2：在 AOV 网中删除该顶点，并删除这个顶点的所有出边；

  - Step 3：重复前两步，直到 AOV 网中不再有入度为 0 的顶点为止。

这样的操作有两个结果：

  - 网中全部顶点被输出，完成拓扑排序。

  - 网中还有未能输出的顶点，说明网中存在回路，不存在拓扑序列。

图采用邻接表表示法，算法时间复杂度为 :math:`\mathcal{O}(n + e)` ；采用邻接矩阵表示法，时间复杂度为 :math:`\mathcal{O}(n^2)` 。


.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
      :linenos:

      // G 用邻接表表示
      #define MAX_N 50

      typedef struct ArcNode
      {
        int adjVex;              // 邻接点的下标
        WeightType weight;       // 邻边的权重
        ArcNode* nextArc;        // 顶点 adjVex 的直接后继
      }ArcNode;

      typedef struct VertexNode
      {
        VertexType data;           // 顶点的数据
        ArcNode* firstArc;         // 边链的头指针
      }VertexNode, AdjList[MAX_N];

      typedef struct
      {
        AdjList vertices;         // 顶点数组
        int vexnum, arcnum;       // 顶点数，边数
      }Graph;


      // 排序
      void topoSort(Graph G)
      {
        int cnt = 0; // 已经输出的顶点个数
        int InDegree[MAX_N] = {0};

        stack<int> S;
        for(int i = 0; i < G.vexnum; ++i)
        {
          for(auto p = G.vertices[i].firstArc; p; p = p -> nextArc)
          {
            InDegree[p -> adjVex] ++; // 统计每个顶点的入度
          }
        }

        for(int i = 0; i < G.vexnum; ++i)
        {
          if(InDegree[i] == 0) S.push(i);
        }

        while(! S.empty())
        {
          int v = S.top();
          S.pop();
          cout << v;
          cnt ++;
          for(auto p = G.vertices[v].firstArc; p; p = p -> nextArc)
          {
            int u = p -> adjVex;
            InDegree[u] --; // v 的所有出边入度减 1
            if(InDegree[u] == 0) S.push(u);
          }
        }

        if(cnt < G.vexnum) cout << "存在环";
      }

|
