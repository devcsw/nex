package egovframework.nex.lotto.service.impl;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.nex.lotto.service.LottoVO;

@Repository("LottoDAO")
public class LottoDAO extends EgovAbstractMapper {

    /**
     * 게시판 추가기능 정보 한 건을 상세조회 한다.
     *
     * @param LottoVOVO
     */
    public LottoVO select() throws Exception {
	return (LottoVO)selectOne("LottoDAO.select");
    }

    /**
     * 게시판 추가기능 정보를 수정한다.
     *
     * @param LottoVO
     */
    public int update(LottoVO lottoVO) throws Exception {
	return update("LottoDAO.update", lottoVO);
    }
    /**
     * 게시판 추가기능 정보를 수정한다.
     *
     * @param LottoVO
     */
    public void lottoLog(LottoVO lottoVO) throws Exception {
    	insert("LottoDAO.lottoLog", lottoVO);
    }
}
