package com.hxzy.vo;

import java.util.List;

/**
 * 底部dao返回的结果
 * @author Administrator
 *
 * @param <T>
 */
public class PageData<T> {

	private long total; // 总记录数

	private List<T> rows; // 每页的记录

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

}
