package egovframework.nex.lotto.service;

public interface LottoService {

	/**
	 * 게시물 한 건을 삭제 한다.
	 *
	 * @param Board
	 * @exception Exception Exception
	 */
	public LottoVO select() throws Exception;

	public int update(LottoVO lottoVO) throws Exception;

	public void lottoLog(LottoVO lottoVO) throws Exception;
}