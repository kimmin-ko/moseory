package com.moseory.dao;

import java.util.List;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.moseory.domain.Criteria;
import com.moseory.domain.NoticeVO;

// NoticeMapper.xml에 있는 쿼리문을 가져와 DB에 접근하기 위한 클래스이다.

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Inject
	private SqlSession sqlSession;

	private static String namespace = "com.moseory.mapper.NoticeMapper";
	// xml의 namespace 명과 동일해야 한다

	@Override
	public void create(NoticeVO vo) {
		sqlSession.insert(namespace + ".insert", vo);
	}

	@Override
	public List<NoticeVO> noticeList() {
		return sqlSession.selectList(namespace + ".list");
	}

	@Override
	public NoticeVO read(int No) {
		return sqlSession.selectOne(namespace + ".select", No);
	}

	@Override
	public void update(NoticeVO vo) {
		sqlSession.update(namespace + ".update", vo);
	}

	@Override
	public void delete(int notice_no) {
		sqlSession.delete(namespace + ".delete", notice_no);
	}

	@Override
	public List<NoticeVO> getListWithPaging(Criteria cri){
		return sqlSession.selectList(namespace+".getListWithPaging",cri);
	}

}
