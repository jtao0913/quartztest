<%@ page language="java" pageEncoding="UTF-8"%>

<style type="text/css">
.map {
	width: 700px;
	height: 350px;
}
</style>
<script src="<%=basePath%>analyse/echarts.min.js"></script>
<script src="<%=basePath%>analyse/china.js"></script>
<script src="<%=basePath%>analyse/theme/shine.js"></script>

<div class="map" id="中国"></div>

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
						max : 305506,
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
				            map:'山东',
//				            mapType: '山东',
				            roam: false,
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
			                      name: "青岛市",
			                      value: 143463
			                    },
			                    {
			                      name: "济南市",
			                      value: 84798
			                    },
			                    {
			                      name: "烟台市",
			                      value: 30511
			                    },
			                    {
			                      name: "潍坊市",
			                      value: 28137
			                    },
			                    {
			                      name: "威海市",
			                      value: 18061
			                    },
			                    {
			                      name: "淄博市",
			                      value: 17834
			                    },
			                    {
			                      name: "泰安市",
			                      value: 15429
			                    },
			                    {
			                      name: "临沂市",
			                      value: 12194
			                    },
			                    {
			                      name: "济宁市",
			                      value: 10709
			                    },
			                    {
			                      name: "滨州市",
			                      value: 9334
			                    },
			                    {
			                      name: "东营市",
			                      value: 8500
			                    },
			                    {
			                      name: "聊城市",
			                      value: 7212
			                    },
			                    {
			                      name: "菏泽市",
			                      value: 6974
			                    },
			                    {
			                      name: "枣庄市",
			                      value: 6098
			                    },
			                    {
			                      name: "德州市",
			                      value: 5644
			                    },
			                    {
			                      name: "日照市",
			                      value: 4768
			                    },
			                    {
			                      name: "莱芜市",
			                      value: 4537
			                    }
				            ]
				        },
				        {
				            name: '实用新型',
				            type: 'map',
				            map:'山东',
//				            mapType: '山东',
				            roam: false,
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
			                      name: "青岛市",
			                      value: 102883
			                    },
			                    {
			                      name: "济南市",
			                      value: 102035
			                    },
			                    {
			                      name: "潍坊市",
			                      value: 60968
			                    },
			                    {
			                      name: "济宁市",
			                      value: 46610
			                    },
			                    {
			                      name: "烟台市",
			                      value: 39039
			                    },
			                    {
			                      name: "淄博市",
			                      value: 33649
			                    },
			                    {
			                      name: "东营市",
			                      value: 27978
			                    },
			                    {
			                      name: "泰安市",
			                      value: 23970
			                    },
			                    {
			                      name: "威海市",
			                      value: 23266
			                    },
			                    {
			                      name: "临沂市",
			                      value: 21165
			                    },
			                    {
			                      name: "滨州市",
			                      value: 21126
			                    },
			                    {
			                      name: "德州市",
			                      value: 18328
			                    },
			                    {
			                      name: "莱芜市",
			                      value: 17310
			                    },
			                    {
			                      name: "聊城市",
			                      value: 17135
			                    },
			                    {
			                      name: "枣庄市",
			                      value: 14909
			                    },
			                    {
			                      name: "菏泽市",
			                      value: 14201
			                    },
			                    {
			                      name: "日照市",
			                      value: 12873
			                    }
				            ]
				        },
				        {
				            name: '外观专利',
				            type: 'map',
				            map:'山东',
//				            mapType: '山东',
				            roam: false,
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
			                        name: "青岛市",
			                        value: 29996
			                      },
			                      {
			                        name: "潍坊市",
			                        value: 16709
			                      },
			                      {
			                        name: "济南市",
			                        value: 14602
			                      },
			                      {
			                        name: "烟台市",
			                        value: 13441
			                      },
			                      {
			                        name: "临沂市",
			                        value: 10885
			                      },
			                      {
			                        name: "威海市",
			                        value: 9906
			                      },
			                      {
			                        name: "淄博市",
			                        value: 9270
			                      },
			                      {
			                        name: "济宁市",
			                        value: 5752
			                      },
			                      {
			                        name: "德州市",
			                        value: 4538
			                      },
			                      {
			                        name: "菏泽市",
			                        value: 4052
			                      },
			                      {
			                        name: "滨州市",
			                        value: 3419
			                      },
			                      {
			                        name: "枣庄市",
			                        value: 3348
			                      },
			                      {
			                        name: "泰安市",
			                        value: 3000
			                      },
			                      {
			                        name: "东营市",
			                        value: 2863
			                      },
			                      {
			                        name: "聊城市",
			                        value: 2483
			                      },
			                      {
			                        name: "日照市",
			                        value: 2440
			                      },
			                      {
			                        name: "莱芜市",
			                        value: 561
			                      }
				            ]
				        },
				        {
				            name: '发明授权',
				            type: 'map',
				            map:'山东',
//				            mapType: '山东',
				            roam: false,
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
			                        name: "青岛市",
			                        value: 29164
			                      },
			                      {
			                        name: "济南市",
			                        value: 26535
			                      },
			                      {
			                        name: "烟台市",
			                        value: 7604
			                      },
			                      {
			                        name: "潍坊市",
			                        value: 7014
			                      },
			                      {
			                        name: "淄博市",
			                        value: 5798
			                      },
			                      {
			                        name: "临沂市",
			                        value: 4097
			                      },
			                      {
			                        name: "威海市",
			                        value: 3793
			                      },
			                      {
			                        name: "济宁市",
			                        value: 3492
			                      },
			                      {
			                        name: "滨州市",
			                        value: 3282
			                      },
			                      {
			                        name: "泰安市",
			                        value: 2765
			                      },
			                      {
			                        name: "聊城市",
			                        value: 2715
			                      },
			                      {
			                        name: "东营市",
			                        value: 2581
			                      },
			                      {
			                        name: "莱芜市",
			                        value: 1915
			                      },
			                      {
			                        name: "德州市",
			                        value: 1873
			                      },
			                      {
			                        name: "菏泽市",
			                        value: 1528
			                      },
			                      {
			                        name: "枣庄市",
			                        value: 1506
			                      },
			                      {
			                        name: "日照市",
			                        value: 1141
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
					if(city=='济南市'){
						cityid = 1351;
					}else if(city=='青岛市'){
						cityid = 1362;
					}else if(city=='淄博市'){
						cityid = 1373;
					}else if(city=='枣庄市'){
						cityid = 1382;
					}else if(city=='东营市'){
						cityid = 1389;
					}else if(city=='烟台市'){
						cityid = 1395;
					}else if(city=='潍坊市'){
						cityid = 1408;
					}else if(city=='济宁市'){
						cityid = 1421;
					}else if(city=='泰安市'){
						cityid = 1433;
					}else if(city=='威海市'){
						cityid = 1440;
					}else if(city=='日照市'){
						cityid = 1445;
					}else if(city=='莱芜市'){
						cityid = 1450;
					}else if(city=='临沂市'){
						cityid = 1453;
					}else if(city=='德州市'){
						cityid = 1466;
					}else if(city=='聊城市'){
						cityid = 1478;
					}else if(city=='滨州市'){
						cityid = 1487;
					}else if(city=='菏泽市'){
						cityid = 1495;
					}
					
					/*
					$('#selectdbs').val("14,15,16");					
					$('#showDetail #strSources').val("14,15,16");					
					$("#searchForm #strSources").val("14,15,16");
					*/
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
					initRequestData_Map(cityid);
				});
			}
			
			make_map("", "中国");
</script>