package egovframework.nex.lotto.web;

import javax.annotation.Resource;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import egovframework.nex.lotto.service.LottoService;
import egovframework.nex.lotto.service.LottoVO;

@Controller
public class lottoController {

	@Resource(name = "LottoService")
	private LottoService lottoService;
	@RequestMapping(value="/lotto.do")
    public String lotto(ModelMap model) throws Exception {

		LottoVO lottoVO =  lottoService.select();

		model.addAttribute("lastNum", lottoVO.getNum());

    	return "nex/lotto/lotto";
    }


	@RequestMapping("/getLottoNumber/get.do")
	  @ResponseBody
	    public ResponseEntity<Object> getLottoNumber(@RequestParam String lottoNumber) throws Exception {
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
	}