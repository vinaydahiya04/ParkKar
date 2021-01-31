import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:park_kar/models/parkingLot.dart';

class ParkingLotList extends StatelessWidget {
  ParkingLotList({@required this.lot, @required this.onPress});
  final ParkingModel lot;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(454, 969), allowFontScaling: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          padding: EdgeInsets.all(15),
          height: 120.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              border: Border.all(color: Colors.black12, width: 1.0.h)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 90.0.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(lot.image), fit: BoxFit.fill),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${lot.name}',
                        overflow: TextOverflow.visible,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 17.0.h,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Text(
                        '${lot.address}',
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 12.0.h,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      SizedBox(
                        height: 10.0.h,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹ ${lot.charges}',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 19.0.h,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
