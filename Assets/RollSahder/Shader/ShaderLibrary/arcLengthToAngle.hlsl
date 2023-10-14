float arcLengthToAngle_half(float angle, float _Pitch) {
                        float radical = sqrt(angle * angle + 1.0f);
                        
                        return _Pitch * 0.5f * (angle * radical + log(angle + radical));
                    }