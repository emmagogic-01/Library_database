#!/usr/bin/env python3
import rospy
from sensor_msgs.msg import NavSatFix

def gps_node():
    rospy.init_node('gps_node', anonymous=True)
    pub = rospy.Publisher('/gps/fix', NavSatFix, queue_size=10)
    rate = rospy.Rate(1)  # 1 Hz

    while not rospy.is_shutdown():
        fix = NavSatFix()
        fix.header.stamp = rospy.Time.now()
        fix.header.frame_id = "gps_frame"
        fix.latitude = 40.748817  # Dummy latitude (e.g., Empire State Building)
        fix.longitude = -73.985428  # Dummy longitude
        fix.altitude = 10.0  # Dummy altitude
        pub.publish(fix)
        rate.sleep()

if __name__ == '__main__':
    try:
        gps_node()
    except rospy.ROSInterruptException:
        pass
