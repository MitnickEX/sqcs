package com.fudax.sqcs.bug.modle;

import java.util.ArrayList;

public class LineCharts {
	private String name;
	private String type;
	private String stack;
	private ArrayList<?> data;
	private int yAxisIndex;

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

	public void setStack(String stack) {
		this.stack = stack;
	}

	public String getStack() {
		return stack;
	}

	public ArrayList<?> getData() {
		return data;
	}

	public void setData(ArrayList<?> data) {
		this.data = data;
	}

	public void setYAxisIndex(int yAxisIndex) {
		this.yAxisIndex = yAxisIndex;
	}

	public int getYAxisIndex() {
		return yAxisIndex;
	}
}
