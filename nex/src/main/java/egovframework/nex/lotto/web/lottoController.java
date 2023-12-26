package egovframework.nex.lotto.web;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.uss.umt.service.EgovMberManageService;
import egovframework.nex.lotto.service.LottoService;
import egovframework.nex.lotto.service.LottoVO;

@Controller
public class lottoController {

	@Resource(name = "LottoService")
	private LottoService lottoService;
	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;



	@RequestMapping(value="/lotto.do")
    public String lotto(ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}
		LottoVO lottoVO =  lottoService.select();

		model.addAttribute("lastNum", lottoVO.getNum());

    	return "nex/lotto/lotto";
    }


	@RequestMapping("/getLottoNumber/get.do")
	  @ResponseBody
	    public ResponseEntity<Object> getLottoNumber(@RequestParam String lottoNumber) throws Exception {
			LoginVO user;
			if (EgovUserDetailsHelper.isAuthenticated()) {
				user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
				LottoVO lottoVO = new LottoVO();
				lottoVO.setId(user.getId());
				lottoVO.setTarget("getLottoNumber");
				lottoService.lottoLog(lottoVO);

			} else {
				user = new LoginVO();
				user.setUniqId("anonymous");
			}



	        // URL 설정
	        String url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=" + lottoNumber; // 대상 URL로 바꿔야 합니다.

	        LottoVO lottoVO = new LottoVO();
	        lottoVO.setNum(lottoNumber);
	        lottoService.update(lottoVO);
	        // RestTemplate 초기화
	        RestTemplate restTemplate = new RestTemplate();

	        try {
	            // HTTP 요청 보내고 응답 받기
	            ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);

	            // HTTP 상태 코드 확인
	            if (responseEntity.getStatusCode() == HttpStatus.OK) {
	                // 응답 데이터 파싱
	                String responseBody = responseEntity.getBody();
	                // responseBody를 JSON으로 파싱하여 객체로 변환 (원하는 방식으로 구현)
	                // 여기에서는 responseBody가 JSON 문자열이라고 가정하고 그대로 반환
	                return ResponseEntity.ok(responseBody);
	            } else {
	                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error fetching lotto data");
	            }
	        } catch (Exception e) {
	            // 예외 처리
	            e.printStackTrace();
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error fetching lotto data");
	        }
	    }


		@RequestMapping("/lottoLog.do")
		@ResponseBody
	    public ResponseEntity<Object>  lottoLog(@RequestParam String target) throws Exception {
		// 미인증 사용자에 대한 보안처리
    		LoginVO user;
			if (EgovUserDetailsHelper.isAuthenticated()) {
				user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
				LottoVO lottoVO = new LottoVO();
				lottoVO.setId(user.getId());
				lottoVO.setTarget(target);
				lottoService.lottoLog(lottoVO);
				return  ResponseEntity.ok(HttpStatus.OK);
			}

			return  ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error lotto log");
    	}
	}