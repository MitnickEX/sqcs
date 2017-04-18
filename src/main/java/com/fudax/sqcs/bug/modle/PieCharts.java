package com.fudax.sqcs.bug.modle;

import java.util.List;

public class PieCharts {
	private String name;
	private String type;
	private int yAxis;
	private List<?> data;
	private String style;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setYAxis(int yAxis) {
		this.yAxis = yAxis;
	}

	public int getYAxis() {
		return yAxis;
	}

	public List<?> getData() {
		return data;
	}

	public void setData(List<?> data) {
		this.data = data;
	}

	public void setItemStyle(String style) {
		this.style = style;
	}

	public String getItemStyle() {
		return style;
	}
}
