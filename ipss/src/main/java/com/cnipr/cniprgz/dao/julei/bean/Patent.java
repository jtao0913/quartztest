package com.cnipr.cniprgz.dao.julei.bean;

import java.io.Serializable;

public class Patent implements Serializable{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 主键
	 */
	private String id;

	/**
	 * 检索库
	 */
	private String sources;

	/**
	 * 相似度
	 */
	private String similarity;

	/**
	 * 坐标
	 */
	private String x;
	private String y;
	private String z;

	/**
	 * 显示字段
	 */
	private String display;

	/**
	 * 申请号
	 */
	private String ap;

	/**
	 * 名称
	 */
	private String ti;

	/**
	 * 申请人
	 */
	private String pa;

	/**
	 * ipc
	 */
	private String ipc;

	/**
	 * 国省代码
	 */
	private String cc;

	/**
	 * 区域
	 */
	private String area;

	/**
	 * 趋势
	 */
	private String trend;

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the sources
	 */
	public String getSources() {
		return sources;
	}

	/**
	 * @param sources
	 *            the sources to set
	 */
	public void setSources(String sources) {
		this.sources = sources;
	}

	/**
	 * @return the similarity
	 */
	public String getSimilarity() {
		return similarity;
	}

	/**
	 * @param similarity
	 *            the similarity to set
	 */
	public void setSimilarity(String similarity) {
		this.similarity = similarity;
	}

	/**
	 * @return the x
	 */
	public String getX() {
		return x;
	}

	/**
	 * @param x
	 *            the x to set
	 */
	public void setX(String x) {
		this.x = x;
	}

	/**
	 * @return the y
	 */
	public String getY() {
		return y;
	}

	/**
	 * @param y
	 *            the y to set
	 */
	public void setY(String y) {
		this.y = y;
	}

	/**
	 * @return the z
	 */
	public String getZ() {
		return z;
	}

	/**
	 * @param z
	 *            the z to set
	 */
	public void setZ(String z) {
		this.z = z;
	}

	/**
	 * @return the display
	 */
	public String getDisplay() {
		return display;
	}

	/**
	 * @param display
	 *            the display to set
	 */
	public void setDisplay(String display) {
		this.display = display;
	}

	/**
	 * @return the ap
	 */
	public String getAp() {
		return ap;
	}

	/**
	 * @param ap
	 *            the ap to set
	 */
	public void setAp(String ap) {
		this.ap = ap;
	}

	/**
	 * @return the ti
	 */
	public String getTi() {
		return ti;
	}

	/**
	 * @param ti
	 *            the ti to set
	 */
	public void setTi(String ti) {
		this.ti = ti;
	}

	/**
	 * @return the pa
	 */
	public String getPa() {
		return pa;
	}

	/**
	 * @param pa
	 *            the pa to set
	 */
	public void setPa(String pa) {
		this.pa = pa;
	}

	/**
	 * @return the ipc
	 */
	public String getIpc() {
		return ipc;
	}

	/**
	 * @param ipc
	 *            the ipc to set
	 */
	public void setIpc(String ipc) {
		this.ipc = ipc;
	}

	/**
	 * @return the cc
	 */
	public String getCc() {
		return cc;
	}

	/**
	 * @param cc
	 *            the cc to set
	 */
	public void setCc(String cc) {
		this.cc = cc;
	}

	/**
	 * @return the area
	 */
	public String getArea() {
		return area;
	}

	/**
	 * @param area
	 *            the area to set
	 */
	public void setArea(String area) {
		this.area = area;
	}

	/**
	 * @return the trend
	 */
	public String getTrend() {
		return trend;
	}

	/**
	 * @param trend
	 *            the trend to set
	 */
	public void setTrend(String trend) {
		this.trend = trend;
	}

	@Override
	public String toString() {
		return "Patent [id=" + id + ", sources=" + sources + ", similarity=" + similarity + ", x=" + x + ", y=" + y
				+ ", z=" + z + ", display=" + display + ", ap=" + ap + ", ti=" + ti + ", pa=" + pa + ", ipc=" + ipc
				+ ", cc=" + cc + ", area=" + area + ", trend=" + trend + "]";
	}
	
}
