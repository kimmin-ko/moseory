package com.moseory.util;

import lombok.Data;

@Data
public class PagingUtil {
	
	//페이지 개수 사이즈
	private int pageSize;
	//한 블럭당 페이지 수
	private int blockSize;
	//현재 페이지(default = 1)
	private int curPage;
	//현재 블럭
	private int curBlock;
	//총 리스트 수
	private int totalCnt;
	//총 페이지 수
	private int pageCnt;
	//총 블럭 수
	private int blockCnt;
	//시작페이지
	private int startPage;
	//끝페이지
	private int endPage;
	//이전페이지
	private int prevPage;
	//다음페이지
	private int nextPage;
	
	//db에 사용
	private int start;
	private int finish;
	public PagingUtil(int totalCnt, int curPage) {
		pageSize = 10;
		blockSize = 10;
		setTotalCnt(totalCnt);
		setCurPage(curPage);
		//총 페이지 수 설정(totalCnt/size)
		setPageCnt(totalCnt);
		//총 블럭 수 설정
		setBlockCnt(pageCnt);
		
		blockSetting(curPage);
		
		this.finish = curPage*(pageSize);
		this.start = this.finish - (this.pageSize -1);
	}
	
	public void setPageCnt(int totalCnt) {
		this.pageCnt = (int)Math.ceil(totalCnt*1.0/pageSize);
	}
	public void setBlockCnt(int pageCnt) {
		this.blockCnt = (int)Math.ceil(pageCnt*1.0/blockSize);
	}
	public void blockSetting(int curPage) {
		setCurBlock(curPage);
		this.startPage = (curBlock - 1) * blockSize + 1;
		this.endPage = startPage + blockSize - 1;
		
		if(endPage > pageCnt) {
			this.endPage = pageCnt;
		}
		
		this.prevPage = curPage - 1;
		this.nextPage = curPage + 1;
		
	}
	
	public void setCurBlock(int curPage) {
		this.curBlock = (int)((curPage-1)/blockSize) + 1;
	}
	
}
