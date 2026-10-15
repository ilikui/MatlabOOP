# CH00206：传感器采集处理工程流水线

本节将 CH00204 的采集模型与纯数据处理器组合成可测试的工程流水线，增加状态、时间戳、错误记录和最近一次成功结果保留。该示例使用模拟数据源，不连接真实设备。

## 架构

```mermaid
flowchart LR
    S[数据源 read] --> M[DataAcquisitionModel]
    M --> P[SensorPipeline]
    P --> C[SensorDataProcessor]
    P --> R[结果/状态/时间戳]
    S -. 可替换 .-> H[硬件适配器：需单独实现]
```

## 运行前准备

将以下目录加入 MATLAB 路径：
- `CH002/CH00204`
- `CH002/CH00206`

然后运行：

```matlab
result = demoSensorPipeline();
```

也可以在命令行查看状态：

```matlab
source = MockDataAcquisition([12 13 14]);
model = DataAcquisitionModel(source);
pipeline = SensorPipeline(model);
result = pipeline.run();
pipeline.status
pipeline.lastStartedAt
pipeline.lastCompletedAt
result.summary
```

## 状态与异常策略

- `idle`：尚未执行。
- `running`：正在执行采集和处理。
- `completed`：本次成功，更新结果和成功运行计数。
- `error`：发生异常，保存错误标识与消息，再把原异常抛给调用方。
- 失败不会覆盖 `lastResult`，成功计数也不会增加；调用方可以决定是否重试。
- 时间戳使用 MATLAB `datetime`，方便日志记录；它不是高精度实时调度保证。

## 自动化测试

确保 `CH002/CH00204` 与本目录都在路径中，然后运行：

```matlab
results = runtests('SensorPipelineTest.m');
table(results)
```

测试覆盖正常流水线、结果统计、状态/时间戳、无效数据错误和最近成功结果保留。

## 真实硬件适配原则

真实设备驱动应独立实现 `read()`，并处理设备初始化、超时、断连、资源释放和驱动特定异常。不要把串口、DAQ 或厂商 SDK 调用写进 `SensorPipeline`、`SensorDataProcessor` 或 `Viewer`。硬件适配器应先转换为有限实数向量，再交给现有模型。

## 后续练习

1. 为数据源定义超时和重试策略，并避免无限重试。
2. 将 `datetime` 时间戳与设备采样时间区分开。
3. 为处理器增加可配置的单位换算与限幅策略。
4. 在支持图形界面的 MATLAB 环境中，把流水线结果传给 `Viewer` 展示。
