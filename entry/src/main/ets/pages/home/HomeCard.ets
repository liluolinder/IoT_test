// 导入普通灯光卡片组件
import { NormalLightCard } from '../../components/cards/lights/NormalLightCard';
// 导入标准温度计卡片组件
import { StandardThermometer } from '../../components/cards/thermometers/StandardThermometer';
// 导入设备类定义
import { DeviceClass } from '../../classes/DeviceClass';
// 导入与数据库操作相关的工具函数和设备数组
import { deviceArray, GetDeviceInfoFromRdb, GetSceneInfoFromRdb, refreshDataFromRDB } from '../../tools/DoingToRdb';
// 导入应用存储和持久化相关的工具
import { AppStorageV2, PersistenceV2 } from '@kit.ArkUI';
// 导入缓存共享数据类
import { CacheSHareDataData } from '../../classes/AppStorageV2/CacheShareData';
// 导入持久化共享数据类
import { PersistentShareData } from '../../classes/PersistenceV2/PersistentShareData';

// 定义外部函数来启动自动刷新定时器
function startAutoRefresh(
  refreshData: () => Promise<void>,
  cacheData: CacheSHareDataData,
  setDeviceArray: (newArray: Array<DeviceClass>) => void,
  interval: number
) {
  return setInterval(async () => {
    await refreshData();
    cacheData.isRefresh = false;
    setDeviceArray(deviceArray);
  }, interval);
}

/**
 * HomeCard 组件，用于展示不同场景下的设备卡片
 */
@ComponentV2
export struct HomeCard {
  // 提供一个全局的刷新状态，用于控制是否刷新
  @Provider('isHomeRefresh') isRefresh: boolean = false;
  // 本地缓存共享数据实例，用于存储和管理缓存数据
  @Local cacheSHareDataData: CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData, () => new CacheSHareDataData())!;
  // 本地持久化共享数据实例，用于存储和管理持久化数据
  @Local persistentShareData: PersistentShareData = PersistenceV2.connect(PersistentShareData, () => new PersistentShareData())!;
  // 传入的场景参数，用于筛选要展示的设备
  @Param @Once localScene: string = '';
  // 本地设备数组，存储当前展示的设备信息
  @Local deviceArray: Array<DeviceClass> = deviceArray;
  // 定时器 ID，用于清除定时器
  private refreshIntervalId: number | null = null;

  /**
   * 根据设备类型渲染对应的卡片组件
   * @param item 设备信息对象
   * @returns 渲染的卡片组件或 null
   */
  private renderDeviceCard(item: DeviceClass): NormalLightCard | StandardThermometer | null {
    if (item.deviceType === 'light') {
      return NormalLightCard({
        normalLightName: item.deviceName,
        scene: item.scene,
        idInRdb: item.id,
        isOpen: item.isOpen === 1,
        lightBrightness: item.lightBrightness
      });
    } else if (item.deviceType === 'thermometer') {
      return StandardThermometer({
        standardThermometerName: item.deviceName,
        scene: item.scene,
        idInRdb: item.id
      });
    }
    return null;
  }

  /**
   * 过滤出符合当前场景的设备
   * @returns 过滤后的设备数组
   */
  private filterDevices() {
    return this.deviceArray.filter(item => {
      return this.localScene === '全部' || item.scene === this.localScene;
    });
  }

  /**
   * 组件构建方法，定义组件的 UI 结构和交互逻辑
   */
  build() {
    // 刷新组件，当 refreshing 状态为 true 时触发刷新效果
    Refresh({ refreshing: $$this.cacheSHareDataData.isRefresh }) {
      // 列容器，用于垂直布局子组件
      Column() {
        // 网格容器，用于以网格形式布局设备卡片
        Grid() {
          ForEach(this.filterDevices(), (item: DeviceClass, id: number) => {
            GridItem() {
              if (item.deviceType === 'light') {
                NormalLightCard({
                  normalLightName: item.deviceName,
                  scene: item.scene,
                  idInRdb: item.id,
                  isOpen: item.isOpen === 1,
                  lightBrightness: item.lightBrightness
                });
              } else if (item.deviceType === 'thermometer') {
                StandardThermometer({
                  standardThermometerName: item.deviceName,
                  scene: item.scene,
                  idInRdb: item.id
                });
              }
            }
          });
        }
        .columnsTemplate('repeat(auto-stretch, 150)') // 定义网格列模板
        .rowsGap(20) // 定义网格行间距
        .width('100%') // 设置网格宽度为父容器的 100%
        .height('100%') // 设置网格高度为父容器的 100%
        .margin({ top: 5 }) // 设置网格顶部外边距为 5
        .scrollBar(BarState.Off) // 隐藏网格滚动条
        .multiSelectable(true) // 允许网格项多选
        .borderRadius('20') // 设置网格边框圆角为 20
        .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true }) // 设置网格边缘弹簧效果
        .editMode(true) // 开启网格编辑模式
        .onAppear(() => {
          // 当组件显示时，同时发起获取设备信息和场景信息的请求
          Promise.all([GetDeviceInfoFromRdb(), GetSceneInfoFromRdb()]).then(() => {
            // 请求完成后，更新本地设备数组
            this.deviceArray = deviceArray;
          });
          // 调用外部函数启动自动刷新定时器，每隔 5000 毫秒（5 秒）刷新一次
          this.refreshIntervalId = startAutoRefresh(
            async () => await refreshDataFromRDB(),
            this.cacheSHareDataData,
            (newArray) => this.deviceArray = newArray,
            5000
          );
        })
        .onDisAppear(() => {
          // 当组件消失时，清除定时器，避免内存泄漏
          if (this.refreshIntervalId) {
            clearInterval(this.refreshIntervalId);
          }
        });
      }
      .height('100%') // 设置列容器高度为父容器的 100%
      .width('100%'); // 设置列容器宽度为父容器的 100%
    }
    .onRefreshing(() => {
      // 当触发刷新操作时，发起刷新数据的请求
      refreshDataFromRDB();
      setTimeout(() => {
        // 150ms 后，将刷新状态设置为 false，并更新本地设备数组
        this.cacheSHareDataData.isRefresh = false;
        this.deviceArray = deviceArray;
      }, 150);
    })
    .height('100%'); // 设置刷新组件高度为父容器的 100%
  }
}