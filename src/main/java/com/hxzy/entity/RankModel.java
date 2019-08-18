package com.hxzy.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * rank_model
 * @author 
 */

@Data
public class RankModel implements Serializable {
    /**
     * 等级
     */
    private Integer rankLevel;

    private Integer experience;

    /**
     * 等级名称
     */
    private String rankName;




}