package egovframework.nex.lotto.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.nex.lotto.service.LottoService;
import egovframework.nex.lotto.service.LottoVO;


@Service("LottoService")
public class LottoServiceImple implements LottoService {

    @Resource(name = "LottoDAO")
    private LottoDAO lottoDAO;

	@Override
	public LottoVO select() throws Exception {
		return lottoDAO.select();
	}

	@Override
	public int update(LottoVO lottoVO) throws Exception {
		return lottoDAO.update(lottoVO);
	}

}
