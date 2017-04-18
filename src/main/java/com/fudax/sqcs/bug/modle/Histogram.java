package com.fudax.sqcs.bug.modle;

import java.util.ArrayList;
import java.util.List;

public class Histogram {
	private String name;
	private String type;
	private String stack;
	private List<?> data;
	private int yAxis;
	private int yAxisIndex;

	@SuppressWarnings("rawtypes")
	public Histogram() {
		data = new ArrayList();
	}

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

	public List<?> getData() {
		return data;
	}

	public void setData(List<?> data) {
		this.data = data;
	}

	public void setYAxis(int yAxis) {
		this.yAxis = yAxis;
	}

	public int getYAxis() {
		return yAxis;
	}

	public void setStack(String stack) {
		this.stack = stack;
	}

	public String getStack() {
		return stack;
	}

	public void setYAxisIndex(int yAxisIndex) {
		this.yAxisIndex = yAxisIndex;
	}

	public int getYAxisIndex() {
		return yAxisIndex;
	}

}
