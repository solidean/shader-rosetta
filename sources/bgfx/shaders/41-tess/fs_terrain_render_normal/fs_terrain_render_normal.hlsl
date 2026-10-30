






















float intBitsToFloat(int _x) { return asfloat(_x); }
float2 intBitsToFloat(uint2 _x) { return asfloat(_x); }
float3 intBitsToFloat(uint3 _x) { return asfloat(_x); }
float4 intBitsToFloat(uint4 _x) { return asfloat(_x); }

float uintBitsToFloat(uint _x) { return asfloat(_x); }
float2 uintBitsToFloat(uint2 _x) { return asfloat(_x); }
float3 uintBitsToFloat(uint3 _x) { return asfloat(_x); }
float4 uintBitsToFloat(uint4 _x) { return asfloat(_x); }

uint floatBitsToUint(float _x) { return asuint(_x); }
uint2 floatBitsToUint(float2 _x) { return asuint(_x); }
uint3 floatBitsToUint(float3 _x) { return asuint(_x); }
uint4 floatBitsToUint(float4 _x) { return asuint(_x); }

int floatBitsToInt(float _x) { return asint(_x); }
int2 floatBitsToInt(float2 _x) { return asint(_x); }
int3 floatBitsToInt(float3 _x) { return asint(_x); }
int4 floatBitsToInt(float4 _x) { return asint(_x); }

uint bitfieldReverse(uint _x) { return reversebits(_x); }
uint2 bitfieldReverse(uint2 _x) { return reversebits(_x); }
uint3 bitfieldReverse(uint3 _x) { return reversebits(_x); }
uint4 bitfieldReverse(uint4 _x) { return reversebits(_x); }

uint packHalf2x16(float2 _x)
{
return (f32tof16(_x.y)<<16) | f32tof16(_x.x);
}

float2 unpackHalf2x16(uint _x)
{
return float2(f16tof32(_x & 0xffff), f16tof32(_x >> 16) );
}

struct BgfxSampler2D
{
SamplerState m_sampler;
Texture2D m_texture;
};

struct BgfxISampler2D
{
Texture2D<int4> m_texture;
};

struct BgfxUSampler2D
{
Texture2D<uint4> m_texture;
};

struct BgfxSampler2DArray
{
SamplerState m_sampler;
Texture2DArray m_texture;
};

struct BgfxSampler2DShadow
{
SamplerComparisonState m_sampler;
Texture2D m_texture;
};

struct BgfxSampler2DArrayShadow
{
SamplerComparisonState m_sampler;
Texture2DArray m_texture;
};

struct BgfxSampler3D
{
SamplerState m_sampler;
Texture3D m_texture;
};

struct BgfxISampler3D
{
Texture3D<int4> m_texture;
};

struct BgfxUSampler3D
{
Texture3D<uint4> m_texture;
};

struct BgfxSamplerCube
{
SamplerState m_sampler;
TextureCube m_texture;
};

struct BgfxSamplerCubeArray
{
SamplerState m_sampler;
TextureCubeArray m_texture;
};

struct BgfxSamplerCubeShadow
{
SamplerComparisonState m_sampler;
TextureCube m_texture;
};

struct BgfxSampler2DMS
{
Texture2DMS<float4> m_texture;
};

struct BgfxSampler2DMSArray
{
Texture2DMSArray<float4> m_texture;
};

float4 bgfxTexture2D(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTexture2DBias(BgfxSampler2D _sampler, float2 _coord, float _bias)
{
return _sampler.m_texture.SampleBias(_sampler.m_sampler, _coord, _bias);
}

float4 bgfxTexture2DLod(BgfxSampler2D _sampler, float2 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

float4 bgfxTexture2DLodOffset(BgfxSampler2D _sampler, float2 _coord, float _level, int2 _offset)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level, _offset);
}

float4 bgfxTexture2DProj(BgfxSampler2D _sampler, float3 _coord)
{
float2 coord = _coord.xy * rcp(_coord.z);
return _sampler.m_texture.Sample(_sampler.m_sampler, coord);
}

float4 bgfxTexture2DProj(BgfxSampler2D _sampler, float4 _coord)
{
float2 coord = _coord.xy * rcp(_coord.w);
return _sampler.m_texture.Sample(_sampler.m_sampler, coord);
}

float4 bgfxTexture2DGrad(BgfxSampler2D _sampler, float2 _coord, float2 _dPdx, float2 _dPdy)
{
return _sampler.m_texture.SampleGrad(_sampler.m_sampler, _coord, _dPdx, _dPdy);
}

float4 bgfxTexture2DArray(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTexture2DArrayLod(BgfxSampler2DArray _sampler, float3 _coord, float _lod)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _lod);
}

float4 bgfxTexture2DArrayLodOffset(BgfxSampler2DArray _sampler, float3 _coord, float _level, int2 _offset)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level, _offset);
}

float3 bgfxTextureSize(BgfxSampler2DArray _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float bgfxShadow2D(BgfxSampler2DShadow _sampler, float3 _coord)
{
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, _coord.xy, _coord.z);
}

float bgfxShadow2DProj(BgfxSampler2DShadow _sampler, float4 _coord)
{
float3 coord = _coord.xyz * rcp(_coord.w);
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, coord.xy, coord.z);
}

float2 bgfxTextureSize(BgfxSampler2DShadow _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float bgfxShadow2DArray(BgfxSampler2DArrayShadow _sampler, float4 _coord)
{
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, _coord.xyz, _coord.w);
}

float3 bgfxTextureSize(BgfxSampler2DArrayShadow _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float4 bgfxTexture3D(BgfxSampler3D _sampler, float3 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTexture3DLod(BgfxSampler3D _sampler, float3 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

int4 bgfxTexture3D(BgfxISampler3D _sampler, float3 _coord)
{
uint3 size;
_sampler.m_texture.GetDimensions(size.x, size.y, size.z);
return _sampler.m_texture.Load(int4(_coord * size, 0) );
}

uint4 bgfxTexture3D(BgfxUSampler3D _sampler, float3 _coord)
{
uint3 size;
_sampler.m_texture.GetDimensions(size.x, size.y, size.z);
return _sampler.m_texture.Load(int4(_coord * size, 0) );
}

float4 bgfxTextureCube(BgfxSamplerCube _sampler, float3 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTextureCubeBias(BgfxSamplerCube _sampler, float3 _coord, float _bias)
{
return _sampler.m_texture.SampleBias(_sampler.m_sampler, _coord, _bias);
}

float4 bgfxTextureCubeArray(BgfxSamplerCubeArray _sampler, float4 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTextureCubeArrayLod(BgfxSamplerCubeArray _sampler, float4 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

float4 bgfxTextureCubeLod(BgfxSamplerCube _sampler, float3 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

float4 bgfxTextureCubeGrad(BgfxSamplerCube _sampler, float3 _coord, float3 _dPdx, float3 _dPdy)
{
return _sampler.m_texture.SampleGrad(_sampler.m_sampler, _coord, _dPdx, _dPdy);
}

float2 bgfxTextureSize(BgfxSamplerCube _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float3 bgfxTextureSize(BgfxSamplerCubeArray _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float2 bgfxTextureSize(BgfxSamplerCubeShadow _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float bgfxShadowCube(BgfxSamplerCubeShadow _sampler, float4 _coord)
{
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, _coord.xyz, _coord.w);
}

float4 bgfxTexelFetch(BgfxSampler2D _sampler, int2 _coord, int _lod)
{
return _sampler.m_texture.Load(int3(_coord, _lod) );
}

float4 bgfxTexelFetchOffset(BgfxSampler2D _sampler, int2 _coord, int _lod, int2 _offset)
{
return _sampler.m_texture.Load(int3(_coord, _lod), _offset );
}

float2 bgfxTextureSize(BgfxSampler2D _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float2 bgfxTextureSize(BgfxISampler2D _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float2 bgfxTextureSize(BgfxUSampler2D _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float4 bgfxTextureGather0(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherRed(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather1(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherGreen(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather2(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherBlue(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather3(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherAlpha(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGatherOffset0(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherRed(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGatherOffset1(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherGreen(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGatherOffset2(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherBlue(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGatherOffset3(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherAlpha(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGather0(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherRed(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather1(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherGreen(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather2(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherBlue(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather3(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherAlpha(_sampler.m_sampler, _coord);
}

int4 bgfxTexelFetch(BgfxISampler2D _sampler, int2 _coord, int _lod)
{
return _sampler.m_texture.Load(int3(_coord, _lod) );
}

uint4 bgfxTexelFetch(BgfxUSampler2D _sampler, int2 _coord, int _lod)
{
return _sampler.m_texture.Load(int3(_coord, _lod) );
}

float4 bgfxTexelFetch(BgfxSampler2DMS _sampler, int2 _coord, int _sampleIdx)
{
return _sampler.m_texture.Load(_coord, _sampleIdx);
}

float4 bgfxTexelFetch(BgfxSampler2DMSArray _sampler, int3 _coord, int _sampleIdx)
{
return _sampler.m_texture.Load(_coord, _sampleIdx);
}

float4 bgfxTexelFetch(BgfxSampler2DArray _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

float4 bgfxTexelFetch(BgfxSampler3D _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

int4 bgfxTexelFetch(BgfxISampler3D _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

uint4 bgfxTexelFetch(BgfxUSampler3D _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

float3 bgfxTextureSize(BgfxSampler3D _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float3 bgfxTextureSize(BgfxISampler3D _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float3 bgfxTextureSize(BgfxUSampler3D _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float4 bgfxTexture3DGrad(BgfxSampler3D _sampler, float3 _coord, float3 _dPdx, float3 _dPdy)
{
return _sampler.m_texture.SampleGrad(_sampler.m_sampler, _coord, _dPdx, _dPdy);
}

float4 bgfxTexture3DLodOffset(BgfxSampler3D _sampler, float3 _coord, float _level, int3 _offset)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level, _offset);
}












bool2 lessThan(float2 _a, float2 _b) { return _a < _b; }
bool3 lessThan(float3 _a, float3 _b) { return _a < _b; }
bool4 lessThan(float4 _a, float4 _b) { return _a < _b; }

bool2 lessThanEqual(float2 _a, float2 _b) { return _a <= _b; }
bool3 lessThanEqual(float3 _a, float3 _b) { return _a <= _b; }
bool4 lessThanEqual(float4 _a, float4 _b) { return _a <= _b; }

bool2 greaterThan(float2 _a, float2 _b) { return _a > _b; }
bool3 greaterThan(float3 _a, float3 _b) { return _a > _b; }
bool4 greaterThan(float4 _a, float4 _b) { return _a > _b; }

bool2 greaterThanEqual(float2 _a, float2 _b) { return _a >= _b; }
bool3 greaterThanEqual(float3 _a, float3 _b) { return _a >= _b; }
bool4 greaterThanEqual(float4 _a, float4 _b) { return _a >= _b; }

bool2 notEqual(float2 _a, float2 _b) { return _a != _b; }
bool3 notEqual(float3 _a, float3 _b) { return _a != _b; }
bool4 notEqual(float4 _a, float4 _b) { return _a != _b; }

bool2 equal(float2 _a, float2 _b) { return _a == _b; }
bool3 equal(float3 _a, float3 _b) { return _a == _b; }
bool4 equal(float4 _a, float4 _b) { return _a == _b; }

float mix(float _a, float _b, float _t) { return lerp(_a, _b, _t); }
float2 mix(float2 _a, float2 _b, float2 _t) { return lerp(_a, _b, _t); }
float3 mix(float3 _a, float3 _b, float3 _t) { return lerp(_a, _b, _t); }
float4 mix(float4 _a, float4 _b, float4 _t) { return lerp(_a, _b, _t); }

float mod(float _a, float _b) { return _a - _b * floor(_a / _b); }
float2 mod(float2 _a, float2 _b) { return _a - _b * floor(_a / _b); }
float3 mod(float3 _a, float3 _b) { return _a - _b * floor(_a / _b); }
float4 mod(float4 _a, float4 _b) { return _a - _b * floor(_a / _b); }


float2 vec2_splat(float _x) { return float2(_x, _x); }
float3 vec3_splat(float _x) { return float3(_x, _x, _x); }
float4 vec4_splat(float _x) { return float4(_x, _x, _x, _x); }

uint2 uvec2_splat(uint _x) { return uint2(_x, _x); }
uint3 uvec3_splat(uint _x) { return uint3(_x, _x, _x); }
uint4 uvec4_splat(uint _x) { return uint4(_x, _x, _x, _x); }


float4x4 mtxFromRows(float4 _0, float4 _1, float4 _2, float4 _3)
{
return float4x4(_0, _1, _2, _3);
}

float4x4 mtxFromCols(float4 _0, float4 _1, float4 _2, float4 _3)
{
return transpose(float4x4(_0, _1, _2, _3) );
}

float3x3 mtxFromRows(float3 _0, float3 _1, float3 _2)
{
return float3x3(_0, _1, _2);
}

float3x3 mtxFromCols(float3 _0, float3 _1, float3 _2)
{
return transpose(float3x3(_0, _1, _2) );
}

float3x4 mtxFromRows(float4 _0, float4 _1, float4 _2)
{
return float3x4(_0, _1, _2);
}

float3 mtxGetRow(float3x3 _mtx, int _row)
{
return float3(_mtx[_row]);
}

float3 mtxGetColumn(float3x3 _mtx, int _column)
{
return float3(_mtx[0][_column], _mtx[1][_column], _mtx[2][_column]);
}

float4 mtxGetRow(float3x4 _mtx, int _row)
{
return float4(_mtx[_row]);
}

float3 mtxGetColumn(float3x4 _mtx, int _column)
{
return float3(_mtx[0][_column], _mtx[1][_column], _mtx[2][_column]);
}

float4 mtxGetRow(float4x4 _mtx, int _row)
{
return float4(_mtx[_row]);
}

float4 mtxGetColumn(float4x4 _mtx, int _column)
{
return float4(_mtx[0][_column], _mtx[1][_column], _mtx[2][_column], _mtx[3][_column]);
}

float mtxGetElement(float3x3 _mtx, int _column, int _row)
{
return _mtx[_row][_column];
}

float mtxGetElement(float4x4 _mtx, int _column, int _row)
{
return _mtx[_row][_column];
}

float select(bool _cond, float _true, float _false) { return _cond ? _true : _false; }
float2 select(bool _cond, float2 _true, float2 _false) { return _cond ? _true : _false; }
float3 select(bool _cond, float3 _true, float3 _false) { return _cond ? _true : _false; }
float4 select(bool _cond, float4 _true, float4 _false) { return _cond ? _true : _false; }
float2 select(bool2 _cond, float2 _true, float2 _false) { return (float2(_cond) * _true) + (float2((!_cond) ) * _false); }
float3 select(bool3 _cond, float3 _true, float3 _false) { return (float3(_cond) * _true) + (float3((!_cond) ) * _false); }
float4 select(bool4 _cond, float4 _true, float4 _false) { return (float4(_cond) * _true) + (float4((!_cond) ) * _false); }
int select(bool _cond, int _true, int _false) { return _cond ? _true : _false; }
int2 select(bool _cond, int2 _true, int2 _false) { return _cond ? _true : _false; }
int3 select(bool _cond, int3 _true, int3 _false) { return _cond ? _true : _false; }
int4 select(bool _cond, int4 _true, int4 _false) { return _cond ? _true : _false; }
int2 select(bool2 _cond, int2 _true, int2 _false) { return (int2(_cond) * _true) + (int2((!_cond) ) * _false); }
int3 select(bool3 _cond, int3 _true, int3 _false) { return (int3(_cond) * _true) + (int3((!_cond) ) * _false); }
int4 select(bool4 _cond, int4 _true, int4 _false) { return (int4(_cond) * _true) + (int4((!_cond) ) * _false); }
uint select(bool _cond, uint _true, uint _false) { return _cond ? _true : _false; }
uint2 select(bool _cond, uint2 _true, uint2 _false) { return _cond ? _true : _false; }
uint3 select(bool _cond, uint3 _true, uint3 _false) { return _cond ? _true : _false; }
uint4 select(bool _cond, uint4 _true, uint4 _false) { return _cond ? _true : _false; }
uint2 select(bool2 _cond, uint2 _true, uint2 _false) { return (uint2(_cond) * _true) + (uint2((!_cond) ) * _false); }
uint3 select(bool3 _cond, uint3 _true, uint3 _false) { return (uint3(_cond) * _true) + (uint3((!_cond) ) * _false); }
uint4 select(bool4 _cond, uint4 _true, uint4 _false) { return (uint4(_cond) * _true) + (uint4((!_cond) ) * _false); }

static float4 u_viewRect;
static float4 u_viewTexel;
static float4x4 u_view;
static float4x4 u_invView;
static float4x4 u_proj;
static float4x4 u_invProj;
static float4x4 u_viewProj;
static float4x4 u_invViewProj;
static float4x4 u_modelView;
static float4x4 u_invModelView;
static float4x4 u_modelViewProj;
static float4 u_alphaRef4;
static float4x4 u_model[1];
































float4 imageLoad(Texture2D<float> _image, int2 _uv) { return _image[_uv].xxxx; } int2 imageSize(Texture2D<float> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<float> _image, int2 _uv) { return _image[_uv].xxxx; } void imageStore(RWTexture2D<float> _image, int2 _uv, float4 _value) { _image[_uv] = _value.x; } int2 imageSize(RWTexture2D<float> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<float> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture2DArray<float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<float> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture2DArray<float> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture2DArray<float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<float> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture3D<float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<float> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture3D<float> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture3D<float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
float4 imageLoad(Texture2D<float2> _image, int2 _uv) { return _image[_uv].xyyy; } int2 imageSize(Texture2D<float2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<float2> _image, int2 _uv) { return _image[_uv].xyyy; } void imageStore(RWTexture2D<float2> _image, int2 _uv, float4 _value) { _image[_uv] = _value.xy; } int2 imageSize(RWTexture2D<float2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture2DArray<float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture2DArray<float2> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture2DArray<float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture3D<float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture3D<float2> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture3D<float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
float4 imageLoad(Texture2D<float4> _image, int2 _uv) { return _image[_uv].xyzw; } int2 imageSize(Texture2D<float4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<float4> _image, int2 _uv) { return _image[_uv].xyzw; } void imageStore(RWTexture2D<float4> _image, int2 _uv, float4 _value) { _image[_uv] = _value.xyzw; } int2 imageSize(RWTexture2D<float4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture2DArray<float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture2DArray<float4> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture2DArray<float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture3D<float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture3D<float4> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture3D<float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }

uint4 imageLoad(Texture2D<uint> _image, int2 _uv) { return _image[_uv].xxxx; } int2 imageSize(Texture2D<uint> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(RWTexture2D<uint> _image, int2 _uv) { return _image[_uv].xxxx; } void imageStore(RWTexture2D<uint> _image, int2 _uv, uint4 _value) { _image[_uv] = _value.x; } int2 imageSize(RWTexture2D<uint> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(Texture2DArray<uint> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture2DArray<uint> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture2DArray<uint> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture2DArray<uint> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture2DArray<uint> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(Texture3D<uint> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture3D<uint> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture3D<uint> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture3D<uint> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture3D<uint> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
uint4 imageLoad(Texture2D<uint2> _image, int2 _uv) { return _image[_uv].xyyy; } int2 imageSize(Texture2D<uint2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(RWTexture2D<uint2> _image, int2 _uv) { return _image[_uv].xyyy; } void imageStore(RWTexture2D<uint2> _image, int2 _uv, uint4 _value) { _image[_uv] = _value.xy; } int2 imageSize(RWTexture2D<uint2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(Texture2DArray<uint2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture2DArray<uint2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture2DArray<uint2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture2DArray<uint2> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture2DArray<uint2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(Texture3D<uint2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture3D<uint2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture3D<uint2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture3D<uint2> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture3D<uint2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
uint4 imageLoad(Texture2D<uint4> _image, int2 _uv) { return _image[_uv].xyzw; } int2 imageSize(Texture2D<uint4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(RWTexture2D<uint4> _image, int2 _uv) { return _image[_uv].xyzw; } void imageStore(RWTexture2D<uint4> _image, int2 _uv, uint4 _value) { _image[_uv] = _value.xyzw; } int2 imageSize(RWTexture2D<uint4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(Texture2DArray<uint4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture2DArray<uint4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture2DArray<uint4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture2DArray<uint4> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture2DArray<uint4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(Texture3D<uint4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture3D<uint4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture3D<uint4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture3D<uint4> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture3D<uint4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }

float4 imageLoad(Texture2D<unorm float> _image, int2 _uv) { return _image[_uv].xxxx; } int2 imageSize(Texture2D<unorm float> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<unorm float> _image, int2 _uv) { return _image[_uv].xxxx; } void imageStore(RWTexture2D<unorm float> _image, int2 _uv, float4 _value) { _image[_uv] = _value.x; } int2 imageSize(RWTexture2D<unorm float> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<unorm float> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture2DArray<unorm float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<unorm float> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture2DArray<unorm float> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture2DArray<unorm float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<unorm float> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture3D<unorm float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<unorm float> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture3D<unorm float> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture3D<unorm float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
float4 imageLoad(Texture2D<unorm float2> _image, int2 _uv) { return _image[_uv].xyyy; } int2 imageSize(Texture2D<unorm float2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<unorm float2> _image, int2 _uv) { return _image[_uv].xyyy; } void imageStore(RWTexture2D<unorm float2> _image, int2 _uv, float4 _value) { _image[_uv] = _value.xy; } int2 imageSize(RWTexture2D<unorm float2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<unorm float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture2DArray<unorm float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<unorm float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture2DArray<unorm float2> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture2DArray<unorm float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<unorm float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture3D<unorm float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<unorm float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture3D<unorm float2> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture3D<unorm float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
float4 imageLoad(Texture2D<unorm float4> _image, int2 _uv) { return _image[_uv].xyzw; } int2 imageSize(Texture2D<unorm float4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<unorm float4> _image, int2 _uv) { return _image[_uv].xyzw; } void imageStore(RWTexture2D<unorm float4> _image, int2 _uv, float4 _value) { _image[_uv] = _value.xyzw; } int2 imageSize(RWTexture2D<unorm float4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<unorm float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture2DArray<unorm float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<unorm float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture2DArray<unorm float4> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture2DArray<unorm float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<unorm float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture3D<unorm float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<unorm float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture3D<unorm float4> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture3D<unorm float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }

void imageAtomicAdd(RWTexture2D<uint> _image, int2 _uv, uint4 _value) { InterlockedAdd(_image[_uv], _value.x); }





static float4 bgfx_numWorkGroups;




static float4 bgfx_indirectArgBase;



uint findMSB_(uint x)
{
uint i;
uint mask;
uint res = -1;

for (i = 0; i < 32; i++)
{
mask = 0x80000000 >> i;

if ((x & mask) != 0)
{
res = 31 - i;
break;
}
}

return res;
}

uint parentKey(in uint key)
{
return (key >> 1u);
}

void childrenKeys(in uint key, out uint children[2])
{
children[0] = (key << 1u) | 0u;
children[1] = (key << 1u) | 1u;
}

bool isRootKey(in uint key)
{
return (key == 1u);
}

bool isLeafKey(in uint key)
{
return findMSB_(key) == 31;
}

bool isChildZeroKey(in uint key)
{
return ((key & 1u) == 0u);
}


float3 berp(in float3 v[3], in float2 u)
{
return v[0] + u.x * (v[1] - v[0]) + u.y * (v[2] - v[0]);
}

float4 berp(in float4 v[3], in float2 u)
{
return v[0] + u.x * (v[1] - v[0]) + u.y * (v[2] - v[0]);
}


float3x3 bitToXform(in uint bit)
{
float b = float(bit);
float c = 1.0f - b;

float3 c1 = float3(0.0f, c , b );
float3 c2 = float3(0.5f, b , 0.0f);
float3 c3 = float3(0.5f, 0.0f, c );

return mtxFromCols(c1, c2, c3);
}


float3x3 keyToXform(in uint key)
{
float3 c1 = float3(1.0f, 0.0f, 0.0f);
float3 c2 = float3(0.0f, 1.0f, 0.0f);
float3 c3 = float3(0.0f, 0.0f, 1.0f);

float3x3 xf = mtxFromCols(c1, c2, c3);

while (key > 1u) {
xf = mul(xf, bitToXform(key & 1u));
key = key >> 1u;
}

return xf;
}


float3x3 keyToXform(in uint key, out float3x3 xfp)
{
xfp = keyToXform(parentKey(key));
return keyToXform(key);
}


void subd(in uint key, in float4 v_in[3], out float4 v_out[3])
{
float3x3 xf = keyToXform(key);

float3x4 m = mtxFromRows(v_in[0], v_in[1], v_in[2]);

float3x4 v = mul(xf, m);

v_out[0] = mtxGetRow(v, 0);
v_out[1] = mtxGetRow(v, 1);
v_out[2] = mtxGetRow(v, 2);
}



void subd(in uint key, in float4 v_in[3], out float4 v_out[3], out float4 v_out_p[3])
{
float3x3 xfp; float3x3 xf = keyToXform(key, xfp);

float3x4 m = mtxFromRows(v_in[0], v_in[1], v_in[2]);

float3x4 v = mul(xf, m);
float3x4 vp = mul(xfp, m);

v_out[0] = mtxGetRow(v, 0);
v_out[1] = mtxGetRow(v, 1);
v_out[2] = mtxGetRow(v, 2);

v_out_p[0] = mtxGetRow(vp, 0);
v_out_p[1] = mtxGetRow(vp, 1);
v_out_p[2] = mtxGetRow(vp, 2);
}

uniform float4 u_params[2];





RWBuffer<uint> u_AtomicCounterBuffer : register(u4);
RWBuffer<uint> u_SubdBufferOut : register(u1);

uniform SamplerState u_DmapSamplerSampler : register(s0); uniform Texture2D u_DmapSamplerTexture : register(t0); static BgfxSampler2D u_DmapSampler = {u_DmapSamplerSampler,u_DmapSamplerTexture };
uniform SamplerState u_SmapSamplerSampler : register(s1); uniform Texture2D u_SmapSamplerTexture : register(t1); static BgfxSampler2D u_SmapSampler = {u_SmapSamplerSampler,u_SmapSamplerTexture };


float dmap(float2 pos)
{
return (bgfxTexture2DLod(u_DmapSampler, pos * 0.5 + 0.5, 0).x) * u_params[0].x;
}

float distanceToLod(float z, float lodFactor)
{


return -2.0 * log2(clamp(z * lodFactor, 0.0f, 1.0f));
}

float computeLod(float3 c)
{

c.z += dmap(mtxGetColumn(u_invView, 3).xy);

float3 cxf = mul(u_modelView, float4(c.x, c.y, c.z, 1)).xyz;
float z = length(cxf);

return distanceToLod(z, u_params[0].y);
}

float computeLod(in float4 v[3])
{
float3 c = (v[1].xyz + v[2].xyz) / 2.0;
return computeLod(c);
}

float computeLod(in float3 v[3])
{
float3 c = (v[1].xyz + v[2].xyz) / 2.0;
return computeLod(c);
}

void writeKey(uint primID, uint key)
{
uint idx = 0;

InterlockedAdd(u_AtomicCounterBuffer[0], 2, idx);

u_SubdBufferOut[idx] = primID;
u_SubdBufferOut[idx+1] = key;
}

void updateSubdBuffer(
uint primID
, uint key
, uint targetLod
, uint parentLod
, bool isVisible
)
{

uint keyLod = findMSB_(key);


if ( keyLod < targetLod && !isLeafKey(key) && isVisible)
{
uint children[2]; childrenKeys(key, children);

writeKey(primID, children[0]);
writeKey(primID, children[1]);
}
else if ( keyLod < (parentLod + 1) && isVisible)
{
writeKey(primID, key);
}
else
{

if ( isRootKey(key))
{
writeKey(primID, key);
}

else if ( isChildZeroKey(key)) {
writeKey(primID, parentKey(key));
}

}
}

void updateSubdBuffer(uint primID, uint key, uint targetLod, uint parentLod)
{
updateSubdBuffer(primID, key, targetLod, parentLod, true);
}

void main( float4 gl_FragCoord : SV_POSITION , float2 v_texcoord0 : TEXCOORD0 , out float4 bgfx_FragData0 : SV_TARGET0 )
{
float4 bgfx_VoidFrag = vec4_splat(0.0);

float2 s = bgfxTexture2D(u_SmapSampler, v_texcoord0).rg * u_params[0].x;
float3 n = normalize(float3(-s, 1));
bgfx_FragData0 = float4(abs(n), 1);
}

