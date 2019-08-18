package com.hxzy.service;

import com.hxzy.common.service.BaseService;
import com.hxzy.entity.Member;

public interface MemberService extends BaseService<Member> {

    Member findOne(String email);

    boolean existsValue(Member member);
}
