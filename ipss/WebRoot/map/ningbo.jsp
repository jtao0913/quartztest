<%@ page language="java" pageEncoding="UTF-8"%>

<style type="text/css">
.map {
	width: 600px;
	height: 400px;
	margin-top:50px;
}
</style>
<script src="<%=basePath%>analyse/echarts.min.js"></script>
<script src="<%=basePath%>map/zhejiang/ningbo/zhe4_jiang1_ning2_bo1.js"></script>
<script src="<%=basePath%>analyse/theme/shine.js"></script>

<div class="map" id="宁波"></div>

<script>
			function make_map(cityname, dom_id) {
				achart = echarts.init(document.getElementById(dom_id));
				var option = {
					"title" : [ {
						"textStyle" : {
							"color" : "#000",
							"fontSize" : 18
						},
						"subtext" : "",
						"text" : cityname,
						"top" : "auto",
						"subtextStyle" : {
							"color" : "#aaa",
							"fontSize" : 12
						},
						"left" : "auto"
					} ],
					"legend" : [ {
						"selectedMode" : "multiple",
						"top" : "top",
//						"orient" : "horizontal",
//						"data" : [""],
//						"left" : "center",
						"show" : true,
				        "orient": 'vertical',
				        "left": 'left',
				        "data":['发明专利','实用新型','外观专利','发明授权']
					} ],
					"backgroundColor" : "#fff",
					visualMap : {
						min : 0,
						max : 147643,
						text : [ '高', '低' ],
						realtime : false,
						calculable : true,
						inRange : {
							color : [ 'lightskyblue', 'yellow', 'orangered' ]
						}
					},
					"series" : [ 
						/*
						{
						name : '山东各市',
						type : 'map',//type必须声明为 map 说明该图标为echarts 中map类型
						map : '山东', //这里需要特别注意。如果是中国地图，map值为china，如果为各省市则为中文。这里用北京
						aspectScale : 0.75, //长宽比. default: 0.75
						zoom : 1.2,
						//roam: true,
						itemStyle : {
							normal : {
								label : {
									show : true
								}
							},
							emphasis : {
								label : {
									show : true
								}
							}
						},						
						data : [
				              {
				            	  name: "青岛市",
				            	  value: 305506
				                },
				                {
				                  name: "济南市",
				                  value: 227970
				                },
				                {
				                  name: "潍坊市",
				                  value: 112828
				                },
				                {
				                  name: "烟台市",
				                  value: 90595
				                },
				                {
				                  name: "济宁市",
				                  value: 66563
				                },
				                {
				                  name: "淄博市",
				                  value: 66551
				                },
				                {
				                  name: "威海市",
				                  value: 55026
				                },
				                {
				                  name: "临沂市",
				                  value: 48341
				                },
				                {
				                  name: "泰安市",
				                  value: 45164
				                },
				                {
				                  name: "东营市",
				                  value: 41922
				                },
				                {
				                  name: "滨州市",
				                  value: 37161
				                },
				                {
				                  name: "德州市",
				                  value: 30383
				                },
				                {
				                  name: "聊城市",
				                  value: 29545
				                },
				                {
				                  name: "菏泽市",
				                  value: 26755
				                },
				                {
				                  name: "枣庄市",
				                  value: 25861
				                },
				                {
				                  name: "莱芜市",
				                  value: 24323
				                },
				                {
				                  name: "日照市",
				                  value: 21222
				                }
							]
					}*/
					
				        {
				            name: '发明专利',
				            type: 'map',
				            map:'宁波',
//				            mapType: '山东',
				            roam: false,
				            
				            aspectScale : 0.75, //长宽比. default: 0.75
				            layoutCenter:['50%','50%'],//地图中心点位置['50%','50%']代表在最中间
				            layoutSize: '100%',//地图大小，此处设置为100%
				            
				            label: {
				                normal: {
				                    show: true
				                },
				                emphasis: {
				                    show: true
				                }
				            },
				            data:[
			                    
				                {
				                    name: "鄞州区",
				                    value: 24706
				                  },
				                  {
				                    name: "慈溪市",
				                    value: 11182
				                  },
				                  {
				                    name: "镇海区",
				                    value: 8847
				                  },
				                  {
				                    name: "余姚市",
				                    value: 8770
				                  },
				                  {
				                    name: "江北区",
				                    value: 7637
				                  },
				                  {
				                    name: "北仑区",
				                    value: 7582
				                  },
				                  {
				                    name: "海曙区",
				                    value: 3968
				                  },
				                  {
				                    name: "奉化区",
				                    value: 2964
				                  },
				                  {
				                    name: "宁海县",
				                    value: 2952
				                  },
				                  {
				                    name: "象山县",
				                    value: 2300
				                  }
				            	
				            ]
				        },
				        {
				            name: '实用新型',
				            type: 'map',
				            map:'宁波',
//				            mapType: '山东',
				            roam: false,
				            
				            aspectScale : 0.75, //长宽比. default: 0.75
				            layoutCenter:['50%','50%'],//地图中心点位置['50%','50%']代表在最中间
				            layoutSize: '100%',//地图大小，此处设置为100%
				            
				            label: {
				                normal: {
				                    show: true
				                },
				                emphasis: {
				                    show: true
				                }
				            },
				            data:[
				                {
				                    name: "鄞州区",
				                    value: 48097
				                  },
				                  {
				                    name: "慈溪市",
				                    value: 36328
				                  },
				                  {
				                    name: "余姚市",
				                    value: 17150
				                  },
				                  {
				                    name: "北仑区",
				                    value: 16943
				                  },
				                  {
				                    name: "象山县",
				                    value: 14322
				                  },
				                  {
				                    name: "镇海区",
				                    value: 12451
				                  },
				                  {
				                    name: "海曙区",
				                    value: 10137
				                  },
				                  {
				                    name: "江北区",
				                    value: 9647
				                  },
				                  {
				                    name: "奉化区",
				                    value: 9031
				                  },
				                  {
				                    name: "宁海县",
				                    value: 8521
				                  }
				            ]
				        },
				        {
				            name: '外观专利',
				            type: 'map',
				            map:'宁波',
				            roam: false,
				            
				            aspectScale : 0.75, //长宽比. default: 0.75
				            layoutCenter:['50%','50%'],//地图中心点位置['50%','50%']代表在最中间
				            layoutSize: '100%',//地图大小，此处设置为100%
				            
				            label: {
				                normal: {
				                    show: true
				                },
				                emphasis: {
				                    show: true
				                }
				            },
				            data:[

				                {
				                    name: "鄞州区",
				                    value: 66261
				                  },
				                  {
				                    name: "余姚市",
				                    value: 48226
				                  },
				                  {
				                    name: "慈溪市",
				                    value: 45955
				                  },
				                  {
				                    name: "宁海县",
				                    value: 15339
				                  },
				                  {
				                    name: "北仑区",
				                    value: 9362
				                  },
				                  {
				                    name: "江北区",
				                    value: 7879
				                  },
				                  {
				                    name: "镇海区",
				                    value: 5355
				                  },
				                  {
				                    name: "海曙区",
				                    value: 5288
				                  },
				                  {
				                    name: "奉化区",
				                    value: 3815
				                  },
				                  {
				                    name: "象山县",
				                    value: 1759
				                  }
				            	
				            	
				            	
				            ]
				        },
				        {
				            name: '发明授权',
				            type: 'map',
				            map:'宁波',
//				            mapType: '山东',
				            roam: false,
				            
				            aspectScale : 0.75, //长宽比. default: 0.75
				            layoutCenter:['50%','50%'],//地图中心点位置['50%','50%']代表在最中间
				            layoutSize: '100%',//地图大小，此处设置为100%
				            
				            label: {
				                normal: {
				                    show: true
				                },
				                emphasis: {
				                    show: true
				                }
				            },
				            data:[
			                   
				                {
				                    name: "鄞州区",
				                    value: 8579
				                  },
				                  {
				                    name: "慈溪市",
				                    value: 3571
				                  },
				                  {
				                    name: "江北区",
				                    value: 3383
				                  },
				                  {
				                    name: "余姚市",
				                    value: 3014
				                  },
				                  {
				                    name: "镇海区",
				                    value: 2861
				                  },
				                  {
				                    name: "北仑区",
				                    value: 2820
				                  },
				                  {
				                    name: "海曙区",
				                    value: 1419
				                  },
				                  {
				                    name: "宁海县",
				                    value: 1079
				                  },
				                  {
				                    name: "奉化区",
				                    value: 870
				                  },
				                  {
				                    name: "象山县",
				                    value: 665
				                  }
				                  
				            ]
				        }
					
					
						]
				};
				achart.setOption(option);

				achart.on('click', function(params) {
					var city = params.name;
					//alert(city);
					
					var cityid = 0;
					if(city=='鄞州区'){
						cityid = 936;
					}else if(city=='余姚市'){
						cityid = 936;
					}else if(city=='慈溪市'){
						cityid = 938;
					}else if(city=='宁海县'){
						cityid = 939;
					}else if(city=='象山县'){
						cityid = 940;
					}else if(city=='海曙区'){
						cityid = 941;
					}else if(city=='奉化区'){
						cityid = 942;
					}else if(city=='北仑区'){
						cityid = 943;
					}else if(city=='江北区'){
						cityid = 944;
					}else if(city=='镇海区'){
						cityid = 945;
					}

					
					$("#showDetail #strSources").val("14,15,16,17");					
					$("#searchForm #strSources").val("14,15,16,17");
					
					var selectexp = "市级行政="+city;
					var selectdbs = "14,15,16,17";
					/*
					params.selectdbs
					params.selectdbs='14,15,16';
					$('#selectdbs').val(params.selectdbs);
					initRequestData(cityid, "CN",1);
					*/

					//var params = {};
/*
					params.nodeId=cityid;
					params.secondsearchexp="";
					params.selectdbs='14,15,16';
					
					params.filterChannel="";
					params.currentPage="1";
					params.language="CN";
*/
					initRequestData_Map(cityid,selectexp,selectdbs);
				});
			}
			
			make_map("", "宁波");
</script>