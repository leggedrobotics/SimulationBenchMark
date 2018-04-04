//
// Created by kangd on 18.02.18.
//

#ifndef MUJOCOSIM_SINGLEBODYOBJECT_HPP
#define MUJOCOSIM_SINGLEBODYOBJECT_HPP

#include <Eigen/Geometry>
#include <mujoco.h>
#include <common/UserHandle.hpp>

#include "common/math.hpp"
#include "common/interface/SingleBodyObjectInterface.hpp"

namespace mujoco_sim {
namespace object {

class SingleBodyObject: public benchmark::object::SingleBodyObjectInterface {

 public:
  SingleBodyObject(mjData *data,
                     mjModel *model,
                     int bodyId,
                     int geomId);

  const Eigen::Map<Eigen::Matrix<double, 4, 1>> getQuaternion() override ;
  void getQuaternion(benchmark::Vec<4>& quat) override ;
  const Eigen::Map<Eigen::Matrix<double, 3, 3> > getRotationMatrix() override ;
  void getRotationMatrix(benchmark::Mat<3,3>& rotation) override ;
  const Eigen::Map<Eigen::Matrix<double, 3, 1> > getPosition() override ;
  const Eigen::Map<Eigen::Matrix<double, 3, 1> > getComPosition() override ;
  const Eigen::Map<Eigen::Matrix<double, 3, 1> > getLinearVelocity() override ;
  const Eigen::Map<Eigen::Matrix<double, 3, 1> > getAngularVelocity() override ;
  void getPosition_W(benchmark::Vec<3>& pos_w) override ;

  void setExternalForce(Eigen::Vector3d force) override ;
  void setExternalTorque(Eigen::Vector3d torque) override ;

  void setFrictionCoefficient(double friction) override ;
 private:

  /// deprecated overrided functions
  /// ===================================
  void setPosition(Eigen::Vector3d originPosition) override ;
  void setPosition(double x, double y, double z) override ;
  void setOrientation(Eigen::Quaterniond quaternion) override ;
  void setOrientation(double w, double x, double y, double z) override ;
  void setOrientation(Eigen::Matrix3d rotationMatrix) override ;
  void setOrientationRandom() override ;
  void setPose(Eigen::Vector3d originPosition, Eigen::Quaterniond quaternion) override ;
  void setPose(Eigen::Vector3d originPosition, Eigen::Matrix3d rotationMatrix) override ;
  void setVelocity(Eigen::Vector3d linearVelocity, Eigen::Vector3d angularVelocity) override ;
  void setVelocity(double dx, double dy, double dz, double wx, double wy, double wz) override ;

  void setRestitutionCoefficient(double restitution) override ;

  bool isVisualizeFramesAndCom() const override ;
  /// ===================================

  mjtNum *getGeomPosition();
  mjtNum *getGeomRotMat();
  mjtNum *getBodyComPosition();

  mjtNum *getBodyLinearVelocity();
  mjtNum *getBodyAngularVelocity();

  void setGeomFriction(benchmark::Vec<3> friction);

 protected:
  int bodyID_ = 0;    // body id in world
  int geomID_ = 0;    // geometry id in body

  mjData* worldData_;
  mjModel* worldModel_;

  // pose and velocity
  benchmark::Vec<4> quatTemp_ = {1.0, 0.0, 0.0, 0.0};
  benchmark::Mat<3, 3> rotMatTemp_;
  benchmark::Vec<3> posTemp_ = {0.0, 0.0, 0.0};
  benchmark::Vec<3> linVelTemp_ = {0.0, 0.0, 0.0};
  benchmark::Vec<3> angVelTemp_ = {0.0, 0.0, 0.0};

};

} // object
} // mujoco_sim

#endif //MUJOCOSIM_SINGLEBODYOBJECT_HPP