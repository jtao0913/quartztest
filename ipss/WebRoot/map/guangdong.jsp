<%@ page language="java" pageEncoding="UTF-8"%>

<style type="text/css">
.map {
	width: 800px;
	height: 400px;
	margin-top:50px;
}
</style>
<script src="<%=basePath%>analyse/echarts.min.js"></script>
<script src="<%=basePath%>analyse/theme/shine.js"></script>
<script src="<%=basePath%>/map/guangdong/guangdong.js"></script>

<div class="map" id="广东"></div>
<!-- 
GET /cn_patent/_search
{
  "from": 0,
  "size": 0,
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "省级行政": "广东省"
          }
        }
      ]
    }
  },
  "aggs": {
    "_type": {
      "terms": {
        "field": "_type",
        "size": 50
      },
      "aggs":{
        "市级行政":{
          "terms": {
            "field": "市级行政",
            "size": 100
          }
        }
      }
    }
  }
}
 -->
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
						max : 975024,
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
					}
						*/
					
				        {
				            name: '发明专利',
				            type: 'map',
				            map:'广东',
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
				                    name: "深圳市",
				                    value: 361774
				                  },
				                  {
				                    name: "广州市",
				                    value: 142641
				                  },
				                  {
				                    name: "佛山市",
				                    value: 72336
				                  },
				                  {
				                    name: "东莞市",
				                    value: 70622
				                  },
				                  {
				                    name: "珠海市",
				                    value: 30216
				                  },
				                  {
				                    name: "中山市",
				                    value: 26792
				                  },
				                  {
				                    name: "惠州市",
				                    value: 24357
				                  },
				                  {
				                    name: "江门市",
				                    value: 16108
				                  },
				                  {
				                    name: "汕头市",
				                    value: 9255
				                  },
				                  {
				                    name: "肇庆市",
				                    value: 4598
				                  },
				                  {
				                    name: "茂名市",
				                    value: 4089
				                  },
				                  {
				                    name: "湛江市",
				                    value: 3866
				                  },
				                  {
				                    name: "韶关市",
				                    value: 3425
				                  },
				                  {
				                    name: "潮州市",
				                    value: 2289
				                  },
				                  {
				                    name: "清远市",
				                    value: 2108
				                  },
				                  {
				                    name: "揭阳市",
				                    value: 1594
				                  },
				                  {
				                    name: "河源市",
				                    value: 1572
				                  },
				                  {
				                    name: "梅州市",
				                    value: 1413
				                  },
				                  {
				                    name: "汕尾市",
				                    value: 1268
				                  },
				                  {
				                    name: "云浮市",
				                    value: 1030
				                  },
				                  {
				                    name: "阳江市",
				                    value: 701
				                  }
				            ]
				        },
				        {
				            name: '实用新型',
				            type: 'map',
				            map:'广东',
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
				                    name: "深圳市",
				                    value: 272533
				                  },
				                  {
				                    name: "广州市",
				                    value: 158459
				                  },
				                  {
				                    name: "东莞市",
				                    value: 135388
				                  },
				                  {
				                    name: "佛山市",
				                    value: 119872
				                  },
				                  {
				                    name: "中山市",
				                    value: 55749
				                  },
				                  {
				                    name: "珠海市",
				                    value: 39961
				                  },
				                  {
				                    name: "惠州市",
				                    value: 29971
				                  },
				                  {
				                    name: "江门市",
				                    value: 25286
				                  },
				                  {
				                    name: "汕头市",
				                    value: 17082
				                  },
				                  {
				                    name: "肇庆市",
				                    value: 8371
				                  },
				                  {
				                    name: "湛江市",
				                    value: 8133
				                  },
				                  {
				                    name: "梅州市",
				                    value: 7154
				                  },
				                  {
				                    name: "韶关市",
				                    value: 6920
				                  },
				                  {
				                    name: "潮州市",
				                    value: 5167
				                  },
				                  {
				                    name: "清远市",
				                    value: 4915
				                  },
				                  {
				                    name: "揭阳市",
				                    value: 4748
				                  },
				                  {
				                    name: "茂名市",
				                    value: 4591
				                  },
				                  {
				                    name: "河源市",
				                    value: 4101
				                  },
				                  {
				                    name: "阳江市",
				                    value: 3297
				                  },
				                  {
				                    name: "汕尾市",
				                    value: 2257
				                  },
				                  {
				                    name: "云浮市",
				                    value: 2245
				                  }
				            ]
				        },
				        {
				            name: '外观专利',
				            type: 'map',
				            map:'广东',
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
				                    name: "深圳市",
				                    value: 204508
				                  },
				                  {
				                    name: "佛山市",
				                    value: 143546
				                  },
				                  {
				                    name: "广州市",
				                    value: 139886
				                  },
				                  {
				                    name: "东莞市",
				                    value: 113592
				                  },
				                  {
				                    name: "中山市",
				                    value: 103031
				                  },
				                  {
				                    name: "汕头市",
				                    value: 62699
				                  },
				                  {
				                    name: "江门市",
				                    value: 40052
				                  },
				                  {
				                    name: "潮州市",
				                    value: 29435
				                  },
				                  {
				                    name: "惠州市",
				                    value: 26322
				                  },
				                  {
				                    name: "揭阳市",
				                    value: 19309
				                  },
				                  {
				                    name: "珠海市",
				                    value: 17533
				                  },
				                  {
				                    name: "阳江市",
				                    value: 12569
				                  },
				                  {
				                    name: "湛江市",
				                    value: 7900
				                  },
				                  {
				                    name: "韶关市",
				                    value: 6524
				                  },
				                  {
				                    name: "茂名市",
				                    value: 6278
				                  },
				                  {
				                    name: "梅州市",
				                    value: 5346
				                  },
				                  {
				                    name: "肇庆市",
				                    value: 4946
				                  },
				                  {
				                    name: "汕尾市",
				                    value: 3844
				                  },
				                  {
				                    name: "清远市",
				                    value: 3550
				                  },
				                  {
				                    name: "河源市",
				                    value: 3051
				                  },
				                  {
				                    name: "云浮市",
				                    value: 2915
				                  }
				            ]
				        },
				        {
				            name: '发明授权',
				            type: 'map',
				            map:'广东',
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
				                    name: "深圳市",
				                    value: 136209
				                  },
				                  {
				                    name: "广州市",
				                    value: 49413
				                  },
				                  {
				                    name: "东莞市",
				                    value: 18485
				                  },
				                  {
				                    name: "佛山市",
				                    value: 17884
				                  },
				                  {
				                    name: "珠海市",
				                    value: 8858
				                  },
				                  {
				                    name: "中山市",
				                    value: 5873
				                  },
				                  {
				                    name: "惠州市",
				                    value: 5439
				                  },
				                  {
				                    name: "江门市",
				                    value: 3359
				                  },
				                  {
				                    name: "汕头市",
				                    value: 2390
				                  },
				                  {
				                    name: "湛江市",
				                    value: 1314
				                  },
				                  {
				                    name: "肇庆市",
				                    value: 1154
				                  },
				                  {
				                    name: "韶关市",
				                    value: 731
				                  },
				                  {
				                    name: "潮州市",
				                    value: 694
				                  },
				                  {
				                    name: "茂名市",
				                    value: 646
				                  },
				                  {
				                    name: "梅州市",
				                    value: 599
				                  },
				                  {
				                    name: "揭阳市",
				                    value: 585
				                  },
				                  {
				                    name: "清远市",
				                    value: 571
				                  },
				                  {
				                    name: "河源市",
				                    value: 328
				                  },
				                  {
				                    name: "汕尾市",
				                    value: 262
				                  },
				                  {
				                    name: "云浮市",
				                    value: 252
				                  },
				                  {
				                    name: "阳江市",
				                    value: 196
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
					if(city=='广州市'){
						cityid = 1941;
					}else if(city=='韶关市'){
						cityid = 1953;
					}else if(city=='深圳市'){
						cityid = 1964;
					}else if(city=='珠海市'){
						cityid = 1973;
					}else if(city=='汕头市'){
						cityid = 1977;
					}else if(city=='佛山市'){
						cityid = 1985;
					}else if(city=='江门市'){
						cityid = 1991;
					}else if(city=='湛江市'){
						cityid = 1999;
					}else if(city=='茂名市'){
						cityid = 2009;
					}else if(city=='肇庆市'){
						cityid = 2015;
					}else if(city=='惠州市'){
						cityid = 2024;
					}else if(city=='梅州市'){
						cityid = 2030;
					}else if(city=='汕尾市'){
						cityid = 2039;
					}else if(city=='河源市'){
						cityid = 2044;
					}else if(city=='阳江市'){
						cityid = 2051;
					}else if(city=='清远市'){
						cityid = 2056;
					}else if(city=='东莞市'){
						cityid = 2065;
					}else if(city=='中山市'){
						cityid = 2067;
					}else if(city=='潮州市'){
						cityid = 2069;
					}else if(city=='揭阳市'){
						cityid = 2073;
					}else if(city=='云浮市'){
						cityid = 2079;
					}
					/*
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
					*/
					
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
			
			make_map("", "广东");
</script>