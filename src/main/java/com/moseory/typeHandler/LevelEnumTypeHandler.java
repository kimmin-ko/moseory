package com.moseory.typeHandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

public class LevelEnumTypeHandler<E extends Enum<?> & BaseLevelEnum> extends BaseTypeHandler<BaseLevelEnum> {

	private Class<E> type;

	public LevelEnumTypeHandler(Class<E> type) {
		if (type == null) {
			throw new IllegalArgumentException("Type argument cannot be null");
		}
		this.type = type;
	}

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, BaseLevelEnum parameter, JdbcType jdbcType)
			throws SQLException {
		ps.setInt(i, parameter.getLevel());
	}

	@Override
	public BaseLevelEnum getNullableResult(ResultSet rs, String columnName) throws SQLException {
		int level = rs.getInt(columnName);
		return rs.wasNull() ? null : levelOf(level);
	}

	@Override
	public BaseLevelEnum getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		int level = rs.getInt(columnIndex);
		return rs.wasNull() ? null : levelOf(level);
	}

	@Override
	public BaseLevelEnum getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		int level = cs.getInt(columnIndex);
		return cs.wasNull() ? null : levelOf(level);
	}

	private E levelOf(int level) {
		try {
			return LevelEnumUtil.levelOf(type, level);
		} catch (Exception ex) {
			throw new IllegalArgumentException(
					"Cannot convert " + level + " to " + type.getSimpleName() + " by level value.", ex);
		}
	}

}
