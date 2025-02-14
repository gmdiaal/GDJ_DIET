package com.goody.diet.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.goody.diet.cart.CartDTO;
import com.goody.diet.util.Pager;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession sqlSession; 
	private final String NAMESPACE = "com.goody.diet.member.MemberDAO.";
	
	public Long getTotalCount(Pager pager) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"getTotalCount", pager);
	}
	
	public List<MemberDTO> getMemberList(Pager pager) throws Exception {
		return sqlSession.selectList(NAMESPACE+"getMemberList", pager);
	}
	
//	public MemberDTO getKakaoLogin (MemberDTO memberDTO) {
//		return sqlSession.selectOne(NAMESPACE+"getKakaoLogin", memberDTO);
//	}
	public int setKakaoJoin (MemberDTO memberDTO) {
		return sqlSession.insert(NAMESPACE+"setKakaoJoin", memberDTO);
	}

	public MemberDTO getMemberLogin(MemberDTO memberDTO) throws Exception {
		memberDTO = sqlSession.selectOne(NAMESPACE+"getMemberLogin", memberDTO);
//		System.out.println(memberDTO.getNames());
		return memberDTO;
	}
	
	public int setMemberJoin(MemberDTO memberDTO) throws Exception {
		return sqlSession.insert(NAMESPACE+"setMemberJoin", memberDTO);
	}

//	public MemberDTO getEmailCheck (MemberDTO memberDTO) throws Exception {
//		return sqlSession.selectOne(NAMESPACE+"getEmailCheck", memberDTO);
//	}
	
	public int setMemberRole(MemberDTO memberDTO) throws Exception {
		return sqlSession.insert(NAMESPACE+"setMemberRole", memberDTO);
	}
	
	public int setMemberDelete(MemberDTO memberDTO) throws Exception {
		return sqlSession.delete(NAMESPACE+"setMemberDelete", memberDTO);
	}
	public int setMemberRoleDelete(MemberDTO memberDTO) throws Exception {
		return sqlSession.delete(NAMESPACE+"setMemberRoleDelete", memberDTO);
	}	
	
	
	//주소설정
	public DeliveryDTO getDeliveryDetail(DeliveryDTO deliveryDTO) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"getDeliveryDetail", deliveryDTO);
	}
	public int setEmailUpdate(MemberDTO memberDTO) throws Exception {
		return sqlSession.update(NAMESPACE+"setEmailUpdate", memberDTO);
	}
	public int setMemberAddressUpdate(MemberDTO memberDTO) throws Exception {
		return sqlSession.update(NAMESPACE+"setMemberAddressUpdate", memberDTO);
	}
	public int setDeliveryAdd(DeliveryDTO deliveryDTO) throws Exception {
		return sqlSession.insert(NAMESPACE+"setDeliveryAdd", deliveryDTO);
	}
	public int setDeliveryDelete(DeliveryDTO deliveryDTO) throws Exception {
		return sqlSession.update(NAMESPACE+"setDeliveryDelete", deliveryDTO);
	}
	public int setdeliveryUpdate(DeliveryDTO deliveryDTO) throws Exception {
		return sqlSession.update(NAMESPACE+"setdeliveryUpdate", deliveryDTO);
	}
	
	
	public int setPasswordUpdate(MemberDTO memberDTO) throws Exception {
		return sqlSession.update(NAMESPACE+"setPasswordUpdate", memberDTO);
	}
	public List<DeliveryDTO> getDeliveryPage (MemberDTO memberDTO) throws Exception {
		return sqlSession.selectList(NAMESPACE+"getDeliveryPage", memberDTO);
	}
	
	public int setDeliveryDeleteOnMemberDelete (MemberDTO memberDTO) throws Exception {
		return sqlSession.delete(NAMESPACE+"setDeliveryDeleteOnMemberDelete", memberDTO);
	}
	public int setOrderDetailDeleteOnMemberDelete (MemberDTO memberDTO) throws Exception {
		return sqlSession.delete(NAMESPACE+"setOrderDetailDeleteOnMemberDelete", memberDTO);
	}
	public int setCartDeleteOnMemberDelete (MemberDTO memberDTO) throws Exception {
		return sqlSession.delete(NAMESPACE+"setCartDeleteOnMemberDelete", memberDTO);
	}
	public int setOrderDeleteOnMemberDelete (MemberDTO memberDTO) throws Exception {
		return sqlSession.delete(NAMESPACE+"setOrderDeleteOnMemberDelete", memberDTO);
	}
	
}
