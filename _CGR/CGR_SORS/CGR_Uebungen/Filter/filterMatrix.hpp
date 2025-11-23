#ifndef FILTER_MATRIX_HPP
#define FILTER_MATRIX
#include <QElapsedTimer>
#include "shader.hpp"
#include "rendering/irenderableproperty.hpp"

//! Diese Klasse realisiert einen einfachen Timer, der als RenderableProperty an Renderables
//! angehängt werden kann.
//! Die zugehörigen Shader erhalten dann den Wert von mTime über die Uniform Time
//! mTime bewegt sich in mMsecsPerIteration von 0 nach 1 und beginnt dann wieder von 0
class FilterMatrix: public IRenderableProperty
{
public:
    FilterMatrix(QMatrix3x3 filterMat) {filter = filterMat;}

    void preRender(Shader &pShader) override {
        pShader.shaderProgram()->setUniformValue("Filter", filter);
    }

protected:
    QMatrix3x3 filter;
};

#endif // FILTER_MATRIX
