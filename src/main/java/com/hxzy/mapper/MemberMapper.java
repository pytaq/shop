package com.hxzy.mapper;

import com.hxzy.common.mapper.BaseMapper;
import com.hxzy.entity.Member;

public interface MemberMapper extends BaseMapper<Member> {


    Member findOne(String email);

    /**
     * 判断会员是否存在
     * @param member
     * @return
     */
    int existsValue(Member member);
}
