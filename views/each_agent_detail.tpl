<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>PlatformAPM</title>
    <!-- 引入 echarts.js -->
    <script src="/assets/echarts.min.js"></script>
</head>
<body>
    <h2>节点基础信息</h2>
    <table border="2" align="left">
        <tr>
            <th>主机名</th>
            <th>IP地址</th>
            <th>CPU</th>
            <th>系统负载信息</th>
            <th>内存(MB)</th>
            <th>当前时间</th>
        </tr>
        <tr>
            % for item in result["agent_static"]:
                <td>{{item}}</td>
            % end
        </tr>
    </table>

    </br></br></br></br></br>

    <!-- 内存信息处理 -->

    % mem_now_time_list = result["agent_mem_use"][0]
    % mem_date_time_list = list()
    % for mem_now_time in mem_now_time_list:
    %   import time
    %   mem_date_time = time.strftime("%Y%m%d-%H:%M:%S", time.localtime(mem_now_time))
    %       mem_date_time_list.append(mem_date_time)
    % end

    <script type="text/javascript">
        var mem_date_arr = new Array();
        % for mem_time_item in mem_date_time_list:
        mem_date_arr.push("{{mem_time_item}}");
        % end
    </script>

    <!-- 为MEM-ECharts准备一个具备大小（宽高）的Dom -->
    <div id="mem" align="left" style="width: 1750px;height:220px;"></div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChartMem = echarts.init(document.getElementById('mem'));
        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '节点内存使用量实时监控'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross',
                    label: {
                        backgroundColor: '#6a7865'
                    }
                }
            },
            legend: {
                data:['内存使用量(MB)']
            },
            toolbox: {
                show: true,
                feature: {
                    dataZoom: {
                        yAxisIndex: 'none'
                    },
                    magicType: {type: ['line', 'bar']},
                    restore: {},
                    saveAsImage: {}
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    name: '时间',
                    nameLocation: 'end',
                    boundaryGap: false,
                    nameGap: 40,
                    <!-- data: {{result["agent_mem_use"][0]}} -->
                    data: mem_date_arr
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    max: {{result["agent_static"][-2]}},
                    axisLabel: {
                        formatter: '{value}MB'
                    },
                    name: '内存使用量(MB)'
                }
            ],
            series: [
                {
                    name: '内存使用量(MB)',
                    type: 'line',
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine: {
                        data: [
                            {type: 'average', name: '平均值'}
                        ]
                    },
                    data: {{result["agent_mem_use"][1]}}
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChartMem.setOption(option);
    </script>

    </br></br></br>


    <!-- CPU 信息处理 -->

        % cpu_now_time_list = result["agent_cpu_use"][0]
        % cpu_date_time_list = list()
        % for cpu_now_time in cpu_now_time_list:
        %   import time
        %   cpu_date_time = time.strftime("%Y%m%d-%H:%M:%S", time.localtime(cpu_now_time))
        %       cpu_date_time_list.append(cpu_date_time)
        % end

        <script type="text/javascript">
            var cpu_date_arr = new Array();
            % for cpu_time_item in cpu_date_time_list:
            cpu_date_arr.push("{{cpu_time_item}}");
            % end
        </script>


    <!-- 为CPU-ECharts准备一个具备大小（宽高）的Dom -->
    <div id="cpu"  align="left" style="width: 1750px;height:220px;"></div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChartCpu = echarts.init(document.getElementById('cpu'));
        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '节点CPU使用率实时监控'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross',
                    label: {
                        backgroundColor: '#6a7865'
                    }
                }
            },
            legend: {
                data:['CPU使用率(%)']
            },
            toolbox: {
                show: true,
                feature: {
                    dataZoom: {
                            yAxisIndex: 'none'
                        },
                    magicType: {type: ['line', 'bar']},
                    restore: {},
                    saveAsImage: {}
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    name: '时间',
                    nameLocation: 'end',
                    boundaryGap: false,
                    nameGap: 40,
                    <!-- data: {{result["agent_cpu_use"][0]}} -->
                    data: cpu_date_arr
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    max: 100.0,
                    axisLabel: {
                        formatter: '{value} %'
                    },
                    name: 'CPU使用率(%)'
                }
            ],
            series: [
                {
                    name: 'CPU使用率(%)',
                    type: 'line',
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine: {
                        data: [
                            {type: 'average', name: '平均值'}
                        ]
                    },
                    data: {{result["agent_cpu_use"][1]}}
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChartCpu.setOption(option);
    </script>

    </br></br></br>

    <!-- 网卡信息处理 -->

    % net_card = result["agent_net_use"][1][1][0].split(":")[1]

        % rx_rates = list()
        % tx_rates = list()
        % for rate in result["agent_net_use"][1]:
        %   rx_rates.append(float(rate[1:][0].split(":")[1]))
        %   tx_rates.append(float(rate[1:][1].split(":")[1]))
        % end

        % net_now_time_list = result["agent_net_use"][0]
        % net_date_time_list = list()
        % for net_now_time in net_now_time_list:
        %   import time
        %   net_date_time = time.strftime("%Y%m%d-%H:%M:%S", time.localtime(net_now_time))
        %       net_date_time_list.append(net_date_time)
        % end

        <script type="text/javascript">
            var net_date_arr = new Array();
            % for net_time_item in net_date_time_list:
            net_date_arr.push("{{net_time_item}}");
            % end
        </script>

    % end


    <!-- 为NET-ECharts准备一个具备大小（宽高）的Dom -->
    <div id="net"  align="left" style="width: 1750px;height:220px;"></div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChartNet = echarts.init(document.getElementById('net'));
        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '节点网卡进出数据实时监控'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross',
                    label: {
                        backgroundColor: '#6a7865'
                    }
                }
            },
            legend: {
                data:['{{net_card}}网卡接收速率(byte/s)', '{{net_card}}网卡发送速率(byte/s)']
            },
            toolbox: {
                show: true,
                feature: {
                    dataZoom: {
                        yAxisIndex: 'none'
                    },
                    magicType: {type: ['line', 'bar']},
                    restore: {},
                    saveAsImage: {}
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    name: '时间',
                    nameLocation: 'end',
                    nameGap: 40,
                    boundaryGap: false,
                    <!-- data: {{net_date_time_list}} -->
                    data: net_date_arr
                 }
            ],
            yAxis: [
                {
                    type: 'value',
                    axisLabel: {
                        formatter: '{value} byte/s'
                    },
                    name: '{{net_card}}网卡吞吐率(byte/s)'
                }
            ],
            series: [
                {
                    name: '{{net_card}}网卡接收速率(byte/s)',
                    type: 'line',
                    markPoint: {
                        data: [
                            {type: 'max', name: '接收最大值'},
                            {type: 'min', name: '接收最小值'}
                        ]
                    },
                    markLine: {
                        data: [
                            {type: 'average', name: '平均值'}
                        ]
                    },
                    data: {{rx_rates}}
                },
                {
                    name: '{{net_card}}网卡发送速率(byte/s)',
                    type: 'line',
                    markPoint: {
                        data: [
                            {type: 'max', name: '发送最大值'},
                            {type: 'min', name: '发送最小值'}
                        ]
                    },
                    markLine: {
                        data: [
                            {type: 'average', name: '平均值'},
                        ]
                    },
                    data: {{tx_rates}}
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChartNet.setOption(option);

    </script>


</body>
</html>