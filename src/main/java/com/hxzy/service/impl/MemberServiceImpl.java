package com.hxzy.service.impl;

import com.hxzy.common.service.BaseService;
import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.entity.Member;
import com.hxzy.mapper.MemberMapper;
import com.hxzy.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class MemberServiceImpl extends BaseServiceImpl<Member> implements MemberService {

    private MemberMapper memberMapper;

    @Autowired
    public void setMemberMapper(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
        super.setBaseMapper(memberMapper);
    }

    @Override
    public Member findOne(String email) {
        return this.memberMapper.findOne(email);
    }

    @Override
    public boolean existsValue(Member member) {
        return this.memberMapper.existsValue(member)>0;
    }
}
