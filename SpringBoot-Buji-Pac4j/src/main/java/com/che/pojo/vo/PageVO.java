package com.che.pojo.vo;

public class PageVO<T> {
	
	private int pageIndex = 1;

	private int pageSize = 10;
	
	private String order = "asc";
	
	private Long total;


	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = ++pageIndex; // miniui pageIndex 差1
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}
}
