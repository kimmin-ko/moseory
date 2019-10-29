package com.moseory.typeHandler;

public class LevelEnumUtil {
    
    public static <E extends Enum<?> & BaseLevelEnum> E levelOf(Class<E> enumClass, int level) {
        E[] enumConstants = enumClass.getEnumConstants();
        for (E e : enumConstants) {
            if (e.getLevel() == level)
                return e;
        }
        return null;
    }
    
}
